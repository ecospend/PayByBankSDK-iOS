//
//  DatalinkRepository.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

typealias DatalinkRepositoryProtocol = DatalinkRepositoryAsyncProtocol & DatalinkRepositorySyncProtocol

protocol DatalinkRepositoryAsyncProtocol {
    func create(request: DatalinkCreateRequest, completion: @escaping (Result<DatalinkCreateResponse, Error>) -> Void)
    func get(request: DatalinkGetRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void)
    func delete(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
    func getConsentDatalink(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void)
}

protocol DatalinkRepositorySyncProtocol {
    func create(request: DatalinkCreateRequest) -> Result<DatalinkCreateResponse, Error>
    func get(request: DatalinkGetRequest) -> Result<DatalinkGetResponse, Error>
    func delete(request: DatalinkDeleteRequest) -> Result<Bool, Error>
    func getConsentDatalink(request: DatalinkGetConsentDatalinkRequest) -> Result<DatalinkGetResponse, Error>
}

class DatalinkRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - DatalinkRepositoryAsyncProtocol
extension DatalinkRepository: DatalinkRepositoryAsyncProtocol {
    
    func create(request: DatalinkCreateRequest, completion: @escaping (Result<DatalinkCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.create(request), type: DatalinkCreateResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func get(request: DatalinkGetRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.get(request), type: DatalinkGetResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.delete(request), type: Bool.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getConsentDatalink(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.getConsentDatalink(request), type: DatalinkGetResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - DatalinkRepositorySyncProtocol
extension DatalinkRepository: DatalinkRepositorySyncProtocol {
    
    func create(request: DatalinkCreateRequest) -> Result<DatalinkCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        create(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func get(request: DatalinkGetRequest) -> Result<DatalinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        get(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func delete(request: DatalinkDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        delete(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getConsentDatalink(request: DatalinkGetConsentDatalinkRequest) -> Result<DatalinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getConsentDatalink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
