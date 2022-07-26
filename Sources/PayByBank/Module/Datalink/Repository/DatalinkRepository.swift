//
//  DatalinkRepository.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

typealias DatalinkRepositoryProtocol = DatalinkRepositoryAsyncProtocol & DatalinkRepositorySyncProtocol

protocol DatalinkRepositoryAsyncProtocol {
    func createDatalink(request: DatalinkCreateRequest, completion: @escaping (Result<DatalinkCreateResponse, Error>) -> Void)
    func getDatalink(request: DatalinkGetRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void)
    func deleteDatalink(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void)
}

protocol DatalinkRepositorySyncProtocol {
    func createDatalink(request: DatalinkCreateRequest) -> Result<DatalinkCreateResponse, Error>
    func getDatalink(request: DatalinkGetRequest) -> Result<DatalinkGetResponse, Error>
    func deleteDatalink(request: DatalinkDeleteRequest) -> Result<Bool, Error>
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest) -> Result<DatalinkGetResponse, Error>
}

class DatalinkRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - DatalinkRepositoryAsyncProtocol
extension DatalinkRepository: DatalinkRepositoryAsyncProtocol {
    
    func createDatalink(request: DatalinkCreateRequest, completion: @escaping (Result<DatalinkCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.create(request), type: DatalinkCreateResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDatalink(request: DatalinkGetRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.get(request), type: DatalinkGetResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteDatalink(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: DatalinkEndpoint.delete(request), type: Bool.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, Error>) -> Void) {
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
    
    func createDatalink(request: DatalinkCreateRequest) -> Result<DatalinkCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createDatalink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getDatalink(request: DatalinkGetRequest) -> Result<DatalinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getDatalink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func deleteDatalink(request: DatalinkDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        deleteDatalink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest) -> Result<DatalinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<DatalinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getDatalinkOfConsent(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
