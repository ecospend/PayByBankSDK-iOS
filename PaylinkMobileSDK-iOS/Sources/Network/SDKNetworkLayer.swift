//
//  SDKNetworkLayer.swift
//  SpeedyPaySDK
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

final class SDKNetworkLayer {
    
    class func request<T: Codable>(router: SDKAPIType, decode decodable: T.Type, completion: @escaping (Result<T, SDKNetworkError>) -> Void) {
        
        // MARK: URL
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.versionPrefix + router.endpoint
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        
        // MARK: HTTP Method
        urlRequest.httpMethod = router.method.rawValue
        
        // MARK: Headers
        for header in router.headers {
            if !router.endpoint.contains("facts") { // TODO: Remove this control
                urlRequest.setValue(header.key, forHTTPHeaderField: header.value)
            }
        }
        
        // MARK: HTTP body
        if router.method == .POST,
           let httpBody = router.body,
           let data = try? JSONSerialization.data(withJSONObject: httpBody) {
            urlRequest.httpBody = data
        }
        
        // MARK: URL Session
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                completion(.failure(SDKNetworkError(error: err as NSError)))
                debugPrint(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(.IncorrectDataReturned))
                return
            }
            guard let responseObject = try? JSONDecoder().decode(decodable, from: data) else {
                completion(.failure(.IncorrectDataReturned))
                return
            }
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
