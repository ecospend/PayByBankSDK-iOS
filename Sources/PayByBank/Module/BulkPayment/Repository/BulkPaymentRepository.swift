//
//  BulkPaymentRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

typealias BulkPaymentRepositoryProtocol = BulkPaymentRepositoryAsyncProtocol & BulkPaymentRepositorySyncProtocol

protocol BulkPaymentRepositoryAsyncProtocol {
    func createBulkPayment(request: BulkPaymentCreateRequest, completion: @escaping (Result<BulkPaymentCreateResponse, Error>) -> Void)
    func getBulkPayment(request: BulkPaymentGetRequest, completion: @escaping (Result<BulkPaymentGetResponse, Error>) -> Void)
    func deleteBulkPayment(request: BulkPaymentDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
}

protocol BulkPaymentRepositorySyncProtocol {
    func createBulkPayment(request: BulkPaymentCreateRequest) -> Result<BulkPaymentCreateResponse, Error>
    func getBulkPayment(request: BulkPaymentGetRequest) -> Result<BulkPaymentGetResponse, Error>
    func deleteBulkPayment(request: BulkPaymentDeleteRequest) -> Result<Bool, Error>
}

class BulkPaymentRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - BulkPaymentRepositoryAsyncProtocol
extension BulkPaymentRepository: BulkPaymentRepositoryAsyncProtocol {
    
    func createBulkPayment(request: BulkPaymentCreateRequest, completion: @escaping (Result<BulkPaymentCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: BulkPaymentEndpoint.createBulkPayment(request), type: BulkPaymentCreateResponse.self, completion: completion)
    }
    
    func getBulkPayment(request: BulkPaymentGetRequest, completion: @escaping (Result<BulkPaymentGetResponse, Error>) -> Void) {
        networking.execute(endpoint: BulkPaymentEndpoint.getBulkPayment(request), type: BulkPaymentGetResponse.self, completion: completion)
    }
    
    func deleteBulkPayment(request: BulkPaymentDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: BulkPaymentEndpoint.deleteBulkPayment(request), type: Bool.self, completion: completion)
    }
}

// MARK: - BulkPaymentRepositorySyncProtocol
extension BulkPaymentRepository: BulkPaymentRepositorySyncProtocol {
    
    func createBulkPayment(request: BulkPaymentCreateRequest) -> Result<BulkPaymentCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<BulkPaymentCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createBulkPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getBulkPayment(request: BulkPaymentGetRequest) -> Result<BulkPaymentGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<BulkPaymentGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getBulkPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func deleteBulkPayment(request: BulkPaymentDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        deleteBulkPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
