//
//  PayByBank.swift
//  PayByBank
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation
import UIKit

/// Paylink API
/// - Note: The Ecospend Gateway presents Paylink as an alternative and easier form of Open Banking Instant Payment solution. Paylink provides you the option of downsizing the development effort for a PIS journey to a single endpoint integration. Paylink undertakes all of interaction in the payment user journey with your branding on display.
public final class Paylink {
    
    private let factory: PaylinkFactoryProtocol
    
    internal init(factory: PaylinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension Paylink {
    
    /// Opens webview using with `uniqueID` of paylink
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of paylink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(uniqueID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(uniqueID), viewController: viewController, completion: completion)
        }
    }
    
    /// Opens webview using with request model of paylink
    ///
    /// - Parameters:
    ///     - request: Request to create paylink
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: PaylinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), viewController: viewController, completion: completion)
        }
    }
    
    /// Creates Paylink
    ///
    /// - Parameters:
    ///     - request: Request to create Paylink
    ///     - completion: It provides to handle result or error
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createPaylink(request: request))
        }
    }
    
    /// Gets Paylink detail
    ///
    /// - Parameters:
    ///     - request: Request to get Paylink detail
    ///     - completion: It provides to handle result or error
    func getPaylink(request: PaylinkGetRequest, completion: @escaping (Result<PaylinkGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getPaylink(request: request))
        }
    }
    
    /// Soft deletes the Paylink with given id.
    ///
    /// - Parameters:
    ///     - request: Request to deactivate Paylink
    ///     - completion: It provides to handle result or error
    func deactivatePaylink(request: PaylinkDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.deactivatePaylink(request: request))
        }
    }
}

// MARK: - Logic
private extension Paylink {
    
    enum PaylinkExecuteType {
        case open(String)
        case initiate(PaylinkCreateRequest)
    }
    
    func execute(type: PaylinkExecuteType, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paylinkRepository = factory.makePaylinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let paylinkGetResult: Result<PaylinkGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch paylinkRepository.getPaylink(request: PaylinkGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch paylinkRepository.createPaylink(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch paylinkRepository.getPaylink(request: PaylinkGetRequest(uniqueID: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PayByBankHandlerProtocol, Error> = {
            switch paylinkGetResult {
            case .success(let response):
                guard let uniqueID = response.uniqueID,
                      let paylinkURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                let handler = factory.makePaylinkHandler(uniqueID: uniqueID,
                                                         webViewURL: paylinkURL,
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
    
    func createPaylink(request: PaylinkCreateRequest) -> Result<PaylinkCreateResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paylinkRepository = factory.makePaylinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paylinkRepository.createPaylink(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func getPaylink(request: PaylinkGetRequest) -> Result<PaylinkGetResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paylinkRepository = factory.makePaylinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paylinkRepository.getPaylink(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func deactivatePaylink(request: PaylinkDeleteRequest) -> Result<Bool, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let paylinkRepository = factory.makePaylinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch paylinkRepository.deletePaylink(request: request) {
        case .success(let isDeleted): return .success(isDeleted)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
}
