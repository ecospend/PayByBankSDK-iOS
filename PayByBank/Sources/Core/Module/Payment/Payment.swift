//
//  Payment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 22.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public final class Payment {
    
    private let factory: PaymentFactoryProtocol
    
    internal init(factory: PaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension Payment {
    
    /// Creates payment.
    ///
    /// - Parameters:
    ///     - request: Request to create payment.
    ///     - completion: It provides to handle result or error.
    func createPayment(request: PaymentCreateRequest,
                       completion: @escaping (Result<PaymentCreateResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createPayment(request: request))
        }
    }
    
    /// Gets payments.
    ///
    /// - Parameters:
    ///     - request: Request to list of payments with filters.
    ///     - completion: It provides to handle result or error.
    func listPayments(request: PaymentListRequest,
                      completion: @escaping (Result<PaymentListResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.listPayments(request: request))
        }
    }
    
    /// Gets payment detail.
    ///
    /// - Parameters:
    ///     - request: Request to get payment detail with id.
    ///     - completion: It provides to handle result or error.
    func getPayment(request: PaymentGetRequest,
                    completion: @escaping (Result<PaymentGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getPayment(request: request))
        }
    }
    
    /// Checks availability of payment url.
    ///
    /// 'url-consumed' endpoint checks whether the bank's payment url has been visited by the PSU.
    /// Return's true if the PSU has logged in to the banking system for this payment.
    /// In such case either wait for the PSU to finish the journey, or create a new payment.
    ///
    /// - Parameters:
    ///     - request: Request to check availability of payment url.
    ///     - completion: It provides to handle result or error.
    func checkPaymentURL(request: PaymentCheckURLRequest,
                         completion: @escaping (Result<PaymentCheckURLResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.checkPaymentURL(request: request))
        }
    }
    
    /// Creates refund for given payment
    ///
    /// - Parameters:
    ///     - request: Request to create refund for given payment.
    ///     - completion: It provides to handle result or error.
    func createRefund(request: PaymentCreateRefundRequest,
                      completion: @escaping (Result<PaymentCreateRefundResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createRefund(request: request))
        }
    }
}

// MARK: - Logic
private extension Payment {
    
    func createPayment(request: PaymentCreateRequest) -> Result<PaymentCreateResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paymentRepository.createPayment(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func listPayments(request: PaymentListRequest) -> Result<PaymentListResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paymentRepository.listPayments(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func getPayment(request: PaymentGetRequest) -> Result<PaymentGetResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paymentRepository.getPayment(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func checkPaymentURL(request: PaymentCheckURLRequest) -> Result<PaymentCheckURLResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paymentRepository.checkPaymentURL(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func createRefund(request: PaymentCreateRefundRequest) -> Result<PaymentCreateRefundResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paymentRepository.createRefund(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
}
