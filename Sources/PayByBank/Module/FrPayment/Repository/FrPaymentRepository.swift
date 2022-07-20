//
//  FrPaymentRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

typealias FrPaymentRepositoryProtocol = FrPaymentRepositoryAsyncProtocol & FrPaymentRepositorySyncProtocol

protocol FrPaymentRepositoryAsyncProtocol {
    func createFrPayment(request: FrPaymentCreateRequest, completion: @escaping (Result<FrPaymentCreateResponse, Error>) -> Void)
    func getFrPayment(request: FrPaymentGetRequest, completion: @escaping (Result<FrPaymentGetResponse, Error>) -> Void)
    func deleteFrPayment(request: FrPaymentDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol FrPaymentRepositorySyncProtocol {
    func createFrPayment(request: FrPaymentCreateRequest) -> Result<FrPaymentCreateResponse, Error>
    func getFrPayment(request: FrPaymentGetRequest) -> Result<FrPaymentGetResponse, Error>
    func deleteFrPayment(request: FrPaymentDeleteRequest) -> Result<Bool, Error>
}

class FrPaymentRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - FrPaymentRepositoryAsyncProtocol
extension FrPaymentRepository: FrPaymentRepositoryAsyncProtocol {
    
    func createFrPayment(request: FrPaymentCreateRequest, completion: @escaping (Result<FrPaymentCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: FrPaymentEndpoint.createFrPayment(request), type: FrPaymentCreateResponse.self, completion: completion)
    }
    
    func getFrPayment(request: FrPaymentGetRequest, completion: @escaping (Result<FrPaymentGetResponse, Error>) -> Void) {
        networking.execute(endpoint: FrPaymentEndpoint.getFrPayment(request), type: FrPaymentGetResponse.self, completion: completion)
    }
    
    func deleteFrPayment(request: FrPaymentDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: FrPaymentEndpoint.deleteFrPayment(request), type: Bool.self, completion: completion)
    }
}

// MARK: - FrPaymentRepositorySyncProtocol
extension FrPaymentRepository: FrPaymentRepositorySyncProtocol {
    func createFrPayment(request: FrPaymentCreateRequest) -> Result<FrPaymentCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<FrPaymentCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createFrPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getFrPayment(request: FrPaymentGetRequest) -> Result<FrPaymentGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<FrPaymentGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getFrPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func deleteFrPayment(request: FrPaymentDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        deleteFrPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
