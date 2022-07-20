//
//  Networking.swift
//  PayByBank
//
//  Created by Yunus TÜR on 13.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

/// Protocol to which a request dispatcher must conform to.
protocol NetworkingProtocol {
    
    /// Required initializer.
    /// - Parameters:
    ///   - networkSession: Instance conforming to `NetworkSessionProtocol` used for executing requests with a specific configuration.
    init(networkSession: NetworkSessionProtocol)
    
    /// Executes a request.
    /// - Warning: If **endpoint.requestType**  is  **.download**,  **type** should be **URL.self**.
    /// - Parameters:
    ///   - endpoint: Instance conforming to `EndpointProtocol`
    ///   - type: Type of response
    ///   - completion: Completion handler.
    @discardableResult
    func execute<T: Decodable>(endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask?
}

// Class that handles the dispatch of requests to an environment with a given configuration.
class Networking: NetworkingProtocol {
    
    /// The network session configuration.
    private var networkSession: NetworkSessionProtocol
    
    /// Required initializer.
    /// - Parameters:
    ///   - networkSession: Instance conforming to `NetworkSessionProtocol` used for executing requests with a specific configuration.
    required init(networkSession: NetworkSessionProtocol) {
        self.networkSession = networkSession
    }
    
    deinit {
        networkSession.invalidateSession()
    }
    
    /// Executes a request.
    /// - Parameters:
    ///   - endpoint: Instance conforming to `EndpointProtocol`
    ///   - completion: Completion handler.
    @discardableResult
    func execute<T: Decodable>(endpoint: EndpointProtocol, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        // Create a URL request.
        guard let urlRequest = endpoint.urlRequest else {
            completion(.failure(NetworkError.badRequest(0, PayByBankStrings.network_error_invalid_url("\(endpoint)").localized)))
            return nil
        }
        // Create a URLSessionTask to execute the URLRequest.
        var task: URLSessionTask?
        switch endpoint.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest, completionHandler: { [weak self] (data, urlResponse, error) in
                self?.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
        case .download(let progressHandler):
            task = networkSession.downloadTask(request: urlRequest, progressHandler: progressHandler, completionHandler: { [weak self] (fileUrl, urlResponse, error) in
                self?.handleFileTaskResponse(fileUrl: fileUrl, urlResponse: urlResponse, error: error, completion: completion)
            })
        case .upload(let fileURL, let progressHandler):
            task = networkSession.uploadTask(with: urlRequest, from: fileURL, progressHandler: progressHandler, completion: { [weak self] (data, urlResponse, error) in
                self?.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
        }
        // Start the task.
        task?.resume()
        
        return task
    }
}

// MARK: - Handle
private extension Networking {
    
    /// Handles the data response that is expected as a JSON object output.
    /// - Parameters:
    ///   - data: The `Data` instance to be serialized into a JSON object.
    ///   - urlResponse: The received  optional `URLResponse` instance.
    ///   - error: The received  optional `Error` instance.
    ///   - completion: Completion handler.
    private func handleJsonTaskResponse<T: Decodable>(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            if let decoded = try? PayByBankConstant.Network.jsonDecoder.decode(T.self, from: data) {
                completion(.success(decoded))
            } else {
                completion(.failure(NetworkError.invalidResponse))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    /// Handles the url response that is expected as a file saved ad the given URL.
    /// - Parameters:
    ///   - fileUrl: The `URL` where the file has been downloaded.
    ///   - urlResponse: The received  optional `URLResponse` instance.
    ///   - error: The received  optional `Error` instance.
    ///   - completion: Completion handler.
    private func handleFileTaskResponse<T: Decodable>(fileUrl: URL?, urlResponse: URLResponse?, error: Error?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }
        
        let result = verify(data: fileUrl, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let url):
            if let decoded = url as? T {
                completion(.success(decoded))
            } else {
                completion(.failure(NetworkError.invalidResponse))
            }
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

// MARK: - Util
private extension Networking {
    
    /// Checks if the HTTP status code is valid and returns an error otherwise.
    /// - Parameters:
    ///   - data: The data or file  URL .
    ///   - urlResponse: The received  optional `URLResponse` instance.
    ///   - error: The received  optional `Error` instance.
    /// - Returns: A `Result` instance.
    private func verify<T>(data: T?, urlResponse: HTTPURLResponse, error: Error?) -> Result<T, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(NetworkError.noData)
            }
        case 400...499:
            return .failure(NetworkError.badRequest(urlResponse.statusCode, repositoryError(data)?.localizedDescription ?? error?.localizedDescription))
        case 500...599:
            return .failure(NetworkError.serverError(urlResponse.statusCode, repositoryError(data)?.localizedDescription ?? error?.localizedDescription))
        default:
            return .failure(NetworkError.unknown(repositoryError(data)?.localizedDescription ?? error?.localizedDescription))
        }
    }
    
    private func repositoryError(_ data: Any?) -> RepositoryErrorResponse? {
        guard let data = data as? Data else { return nil }
        return try? JSONDecoder().decode(RepositoryErrorResponse.self, from: data)
    }
}
