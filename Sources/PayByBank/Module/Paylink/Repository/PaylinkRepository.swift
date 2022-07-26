//
//  PayByBankRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 16.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

typealias PaylinkRepositoryProtocol = PaylinkRepositoryAsyncProtocol & PaylinkRepositorySyncProtocol

protocol PaylinkRepositoryAsyncProtocol {
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void)
    func getPaylink(request: PaylinkGetRequest, completion: @escaping (Result<PaylinkGetResponse, Error>) -> Void)
    func deletePaylink(request: PaylinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol PaylinkRepositorySyncProtocol {
    func createPaylink(request: PaylinkCreateRequest) -> Result<PaylinkCreateResponse, Error>
    func getPaylink(request: PaylinkGetRequest) -> Result<PaylinkGetResponse, Error>
    func deletePaylink(request: PaylinkDeleteRequest) -> Result<Bool, Error>
}

class PaylinkRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - PaylinkRepositoryAsyncProtocol
extension PaylinkRepository: PaylinkRepositoryAsyncProtocol {
    
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.createPaylink(request), type: PaylinkCreateResponse.self, completion: completion)
    }
    
    func getPaylink(request: PaylinkGetRequest, completion: @escaping (Result<PaylinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.getPaylink(request), type: PaylinkGetResponse.self, completion: completion)
    }
    
    func deletePaylink(request: PaylinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.deletePaylink(request), type: Bool.self, completion: completion)
    }
}

// MARK: - PaylinkRepositorySyncProtocol
extension PaylinkRepository: PaylinkRepositorySyncProtocol {
    
    func createPaylink(request: PaylinkCreateRequest) -> Result<PaylinkCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaylinkCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createPaylink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getPaylink(request: PaylinkGetRequest) -> Result<PaylinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaylinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getPaylink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func deletePaylink(request: PaylinkDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        deletePaylink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}