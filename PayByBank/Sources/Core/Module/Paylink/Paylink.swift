//
//  PayByBank.swift
//  PayByBank SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class Paylink {
    
    private let factory: PaylinkFactoryProtocol
    
    internal init(factory: PaylinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension Paylink {
    
    /// Opens webview using with `unique_id` of paylink
    ///
    /// - Parameters:
    ///     - paylinkID: Unique id value of paylink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(paylinkID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(paylinkID), viewController: viewController, completion: completion)
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
            case .open(let paylinkID):
                switch paylinkRepository.getPaylink(request: PaylinkGetRequest(paylinkID: paylinkID)){
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch paylinkRepository.createPaylink(request: request) {
                case .success(let createResponse):
                    guard let paylinkID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch paylinkRepository.getPaylink(request: PaylinkGetRequest(paylinkID: paylinkID)){
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
                guard let paylinkID = response.uniqueID,
                      let paylinkURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                let handler = factory.makePaylinkAPIHandler(uniqueID: paylinkID,
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
}
