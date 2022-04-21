//
//  BulkPayment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class BulkPayment {
    
    private let factory: BulkPaymentFactoryProtocol
    
    internal init(factory: BulkPaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension BulkPayment {
    
    /// Opens webview using with `uniqueID` of the BulkPayment Paylink.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of BulkPayment.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(uniqueID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(uniqueID), viewController: viewController, completion: completion)
        }
    }
    
    /// Opens webview using with request model of the BulkPayment Paylink.
    ///
    /// - Parameters:
    ///     - request: Request to create BulkPayment
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: BulkPaymentCreateRequest, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), viewController: viewController, completion: completion)
        }
    }
    
    /// Soft deletes the BulkPayment Paylink with given id.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of BulkPayment.
    ///     - completion: It provides to handle result or error
    func delete(uniqueID: String, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.delete(request: BulkPaymentDeleteRequest(uniqueID: uniqueID), completion: completion)
        }
    }
}

// MARK: - Logic
private extension BulkPayment {
    
    enum BulkPaymentExecuteType {
        case open(String)
        case initiate(BulkPaymentCreateRequest)
    }
    
    func execute(type: BulkPaymentExecuteType, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let bulkPaymentRepository = factory.makeBulkPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let bulkPaymentGetResult: Result<BulkPaymentGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch bulkPaymentRepository.getBulkPayment(request: BulkPaymentGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch bulkPaymentRepository.createBulkPayment(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch bulkPaymentRepository.getBulkPayment(request: BulkPaymentGetRequest(uniqueID: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PayByBankHandlerProtocol, Error> = {
            switch bulkPaymentGetResult {
            case .success(let response):
                guard let uniqueID = response.uniqueID,
                      let bulkPaymentURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                let handler = factory.makeBulkPaymentHandler(uniqueID: uniqueID,
                                                             webViewURL: bulkPaymentURL,
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
    
    func delete(request: BulkPaymentDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let bulkPaymentRepository = factory.makeBulkPaymentRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        switch bulkPaymentRepository.deleteBulkPayment(request: request) {
        case .success(let isDeleted): return completion(.success(isDeleted))
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
    }
}
