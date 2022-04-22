//
//  PaymentRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

typealias PaymentRepositoryProtocol = PaymentRepositoryAsyncProtocol & PaymentRepositorySyncProtocol

protocol PaymentRepositoryAsyncProtocol {
    func createPayment(request: PaymentCreateRequest, completion: @escaping (Result<PaymentCreateResponse, Error>) -> Void)
    func listPayments(request: PaymentListRequest, completion: @escaping (Result<PaymentListResponse, Error>) -> Void)
    func getPayment(request: PaymentGetRequest, completion: @escaping (Result<PaymentGetResponse, Error>) -> Void)
    func checkPaymentURL(request: PaymentCheckURLRequest, completion: @escaping (Result<PaymentCheckURLResponse, Error>) -> Void)
    func createRefund(request: PaymentCreateRefundRequest, completion: @escaping (Result<PaymentCreateRefundResponse, Error>) -> Void)
}

protocol PaymentRepositorySyncProtocol {
    func createPayment(request: PaymentCreateRequest) -> Result<PaymentCreateResponse, Error>
    func listPayments(request: PaymentListRequest) -> Result<PaymentListResponse, Error>
    func getPayment(request: PaymentGetRequest) -> Result<PaymentGetResponse, Error>
    func checkPaymentURL(request: PaymentCheckURLRequest) -> Result<PaymentCheckURLResponse, Error>
    func createRefund(request: PaymentCreateRefundRequest) -> Result<PaymentCreateRefundResponse, Error>
}

class PaymentRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - PaymentRepositoryAsyncProtocol
extension PaymentRepository: PaymentRepositoryAsyncProtocol {
    
    func createPayment(request: PaymentCreateRequest, completion: @escaping (Result<PaymentCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: PaymentEndpoint.createPayment(request), type: PaymentCreateResponse.self, completion: completion)
    }
    
    func listPayments(request: PaymentListRequest, completion: @escaping (Result<PaymentListResponse, Error>) -> Void) {
        networking.execute(endpoint: PaymentEndpoint.listPayments(request), type: PaymentListResponse.self, completion: completion)
    }
    
    func getPayment(request: PaymentGetRequest, completion: @escaping (Result<PaymentGetResponse, Error>) -> Void) {
        networking.execute(endpoint: PaymentEndpoint.getPayment(request), type: PaymentGetResponse.self, completion: completion)
    }
    
    func checkPaymentURL(request: PaymentCheckURLRequest, completion: @escaping (Result<PaymentCheckURLResponse, Error>) -> Void) {
        networking.execute(endpoint: PaymentEndpoint.checkPaymentURL(request), type: PaymentCheckURLResponse.self, completion: completion)
    }
    
    func createRefund(request: PaymentCreateRefundRequest, completion: @escaping (Result<PaymentCreateRefundResponse, Error>) -> Void) {
        networking.execute(endpoint: PaymentEndpoint.createRefund(request), type: PaymentCreateRefundResponse.self, completion: completion)
    }
}

// MARK: - PaymentRepositorySyncProtocol
extension PaymentRepository: PaymentRepositorySyncProtocol {
    
    func createPayment(request: PaymentCreateRequest) -> Result<PaymentCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaymentCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func listPayments(request: PaymentListRequest) -> Result<PaymentListResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaymentListResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        listPayments(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getPayment(request: PaymentGetRequest) -> Result<PaymentGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaymentGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getPayment(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func checkPaymentURL(request: PaymentCheckURLRequest) -> Result<PaymentCheckURLResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaymentCheckURLResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        checkPaymentURL(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func createRefund(request: PaymentCreateRefundRequest) -> Result<PaymentCreateRefundResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaymentCreateRefundResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createRefund(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
