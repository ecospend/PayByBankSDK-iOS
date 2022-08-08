//
//  FrPayment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

/// FrPayment (Standing Order) API
/// - Note: A Standing Order is an instruction that an account holder gives to their bank to make payments of a fixed amount at regular intervals. Payments are made automatically by the bank on a defined schedule (e.g. weekly or monthly) on an ongoing basis, unless a specified condition has been met, such as an end-date being reached or a set number of payments having been made. Standing Orders can only be created, amended or cancelled by the account holder, typically by using their online or telephone banking service. They are most commonly used for recurring payments where the amount stays the same, such as rent payments, subscription services or regular account top-ups.
public final class FrPayment {
    
    private let factory: FrPaymentFactoryProtocol
    
    internal init(factory: FrPaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension FrPayment {
    
    /// Opens webview using with `uniqueID` of FrPayment
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of FrPayment.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(uniqueID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(uniqueID), viewController: viewController, completion: completion)
        }
    }
    
    /// Opens webview using with request model of FrPayment
    ///
    /// - Parameters:
    ///     - request: Request to create FrPayment
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: FrPaymentCreateRequest, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), viewController: viewController, completion: completion)
        }
    }
    
    /// Creates FrPayment
    ///
    /// - Parameters:
    ///     - request: Request to create FrPayment
    ///     - completion: It provides to handle result or error
    func createFrPayment(request: FrPaymentCreateRequest, completion: @escaping (Result<FrPaymentCreateResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createFrPayment(request: request))
        }
    }
    
    /// Gets FrPayment detail
    ///
    /// - Parameters:
    ///     - request: Request to get FrPayment detail
    ///     - completion: It provides to handle result or error
    func getFrPayment(request: FrPaymentGetRequest, completion: @escaping (Result<FrPaymentGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getFrPayment(request: request))
        }
    }
    
    /// Soft deletes FrPayment with given id
    ///
    /// - Parameters:
    ///     - request: Request to deacvtivate FrPayment
    ///     - completion: It provides to handle result or error
    func deactivateFrPayment(request: FrPaymentDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.deactivateFrPayment(request: request))
        }
    }
}

// MARK: - Logic
private extension FrPayment {
    
    enum FrPaymentExecuteType {
        case open(String)
        case initiate(FrPaymentCreateRequest)
    }
    
    func execute(type: FrPaymentExecuteType, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let frPaymentRepository = factory.makeFrPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let frPaymentGetResult: Result<FrPaymentGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch frPaymentRepository.getFrPayment(request: FrPaymentGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch frPaymentRepository.createFrPayment(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch frPaymentRepository.getFrPayment(request: FrPaymentGetRequest(uniqueID: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PayByBankHandlerProtocol, Error> = {
            switch frPaymentGetResult {
            case .success(let response):
                guard let uniqueID = response.uniqueID,
                      let frPaymentURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                let handler = factory.makeFrPaymentHandler(uniqueID: uniqueID,
                                                           webViewURL: frPaymentURL,
                                                           redirectURL: redirectURL,
                                                           completionHandler: completion)
                return .success(handler)
            case .failure(let error):
                return .failure(error)
            }
        }()
        
        switch handlerResult {
        case .success(let handler):
            DispatchQueue.main.async {
                let vc = self.factory.payByBankFactory.makeWebViewVC(handler: handler)
                let nc = UINavigationController(rootViewController: vc)
                viewController.present(nc, animated: true)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(.failure(PayByBankError(error: error)))
            }
        }
    }
    
    func createFrPayment(request: FrPaymentCreateRequest) -> Result<FrPaymentCreateResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let frPaymentRepository = factory.makeFrPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch frPaymentRepository.createFrPayment(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func getFrPayment(request: FrPaymentGetRequest) -> Result<FrPaymentGetResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let frPaymentRepository = factory.makeFrPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch frPaymentRepository.getFrPayment(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func deactivateFrPayment(request: FrPaymentDeleteRequest) -> Result<Bool, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let frPaymentRepository = factory.makeFrPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch frPaymentRepository.deleteFrPayment(request: request) {
        case .success(let isDeleted): return .success(isDeleted)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
}
