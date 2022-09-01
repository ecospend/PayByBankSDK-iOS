//
//  Payment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 22.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

/// Payment API
/// - Note: Domestic instant payments, international payments, and scheduled payments are all accomplished from the same /payments endpoint. The payment type is automatically identified by our system depending whether the debtor and creditor accounts are from different countries (for international payments), or whether a value has been set for the scheduled_for parameter (meaning a scheduled payment).
public final class Payment {
    
    private let factory: PaymentFactoryProtocol
    
    internal init(factory: PaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension Payment {
    
    /// Opens bank application or bank website using with `id` and`url (payment_url)` of Payment.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - id: A system assigned unique identification for the Payment.
    ///     - url (payment_url): A unique and one time use only URL of the debtor's banking system. You will need to redirect PSU to this link in order the payment to proceed.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func open(id: String,
              url: URL,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.open(id: id, paymentURL: url, completion: completion)
        }
    }
    
    /// Opens bank application or bank website using with `id` of Payment.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - id: A system assigned unique identification for the Payment.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func open(id: String,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(id), completion: completion)
        }
    }
    
    /// Opens bank application or bank website using with request model of Payment.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentCreateRequest`, which is request model to create Payment.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func initiate(request: PaymentCreateRequest,
                  completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), completion: completion)
        }
    }
    
    /// Opens bank application or bank website using with request model of refund of Payment.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentCreateRefundRequest`, which is request model to create refund of Payment.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func initiateRefund(request: PaymentCreateRefundRequest,
                        completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiateRefund(request), completion: completion)
        }
    }
    
    /// Creates Payment.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentCreateRequest`, which is request model to create Payment.
    ///     - completion: It provides to handle `PaymentCreateResponse` or `PayByBankError`.
    func createPayment(request: PaymentCreateRequest,
                       completion: @escaping (Result<PaymentCreateResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createPayment(request: request))
        }
    }
    
    /// Gets Payments.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentListRequest`, which is request model to get Payments.
    ///     - completion: It provides to handle `PaymentListResponse` or `PayByBankError`.
    func listPayments(request: PaymentListRequest,
                      completion: @escaping (Result<PaymentListResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.listPayments(request: request))
        }
    }
    
    /// Gets Payment detail.
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentGetRequest`, which is request model to get details of Payment.
    ///     - completion: It provides to handle `PaymentGetResponse` or `PayByBankError`.
    func getPayment(request: PaymentGetRequest,
                    completion: @escaping (Result<PaymentGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getPayment(request: request))
        }
    }
    
    /// Checks availability of Payment url.
    ///
    /// - Note: This method requires authentication.
    ///
    /// 'url-consumed' endpoint checks whether the bank's payment url has been visited by the PSU.
    /// Return's true if the PSU has logged in to the banking system for this payment.
    /// In such case either wait for the PSU to finish the journey, or create a new payment.
    ///
    /// - Parameters:
    ///     - request:  Instance's `PaymentCheckURLRequest`, which is request model to check availability of Payment url.
    ///     - completion: It provides to handle `PaymentCheckURLResponse` or `PayByBankError`.
    func checkPaymentURL(request: PaymentCheckURLRequest,
                         completion: @escaping (Result<PaymentCheckURLResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.checkPaymentURL(request: request))
        }
    }
    
    /// Creates refund for given payment
    ///
    /// - Note: This method requires authentication.
    ///
    /// - Parameters:
    ///     - request: Instance's `PaymentCreateRefundRequest`, which is request model to create refund for given Payment.
    ///     - completion: It provides to handle `PaymentCreateRefundResponse` or `PayByBankError`.
    func createRefund(request: PaymentCreateRefundRequest,
                      completion: @escaping (Result<PaymentCreateRefundResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createRefund(request: request))
        }
    }
}

// MARK: - Logic
private extension Payment {
    
    enum PaymentExecuteType {
        case open(String)
        case initiate(PaymentCreateRequest)
        case initiateRefund(PaymentCreateRefundRequest)
    }
    
    func execute(type: PaymentExecuteType, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paymentRepository = factory.makePaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let paymentGetResult: Result<PaymentGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch paymentRepository.getPayment(request: PaymentGetRequest(id: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch paymentRepository.createPayment(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.id else { return .failure(PayByBankError.wrongLink) }
                    
                    switch paymentRepository.getPayment(request: PaymentGetRequest(id: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            case .initiateRefund(let request):
                switch paymentRepository.createRefund(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.id else { return .failure(PayByBankError.wrongLink) }
                    
                    switch paymentRepository.getPayment(request: PaymentGetRequest(id: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let paymentResult: Result<(id: String, url: URL), Error> = {
            switch paymentGetResult {
            case .success(let response):
                guard let id = response.id,
                      let url = URL(string: response.url ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                return .success((id, url))
            case .failure(let error): return .failure(error)
            }
        }()
        
        switch paymentResult {
        case .success((let id, let url)):
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
                completion(.success(PayByBankResult(uniqueID: id, status: .redirected)))
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(.failure(PayByBankError(error: error)))
            }
        }
    }
    
    func open(id: String,
              paymentURL: URL,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard paymentURL.isEcospendHost, !id.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.open(paymentURL)
            completion(.success(PayByBankResult(uniqueID: id, status: .redirected)))
        }
    }
    
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
