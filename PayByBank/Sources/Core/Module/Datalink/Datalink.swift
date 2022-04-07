//
//  Datalink.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import Foundation
import UIKit

public final class Datalink {
    
    private let factory: DatalinkFactoryProtocol
    
    internal init(factory: DatalinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension Datalink {
    
    /// Opens webview using with `unique_id` of datalink
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of datalink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(uniqueID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(uniqueID), viewController: viewController, completion: completion)
        }
    }
    
    /// Opens webview using with request model of datalink
    ///
    /// - Parameters:
    ///     - request: Request to create datalink
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: DatalinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), viewController: viewController, completion: completion)
        }
    }
}

// MARK: - Logic
private extension Datalink {
    
    enum DatalinkExecuteType {
        case open(String)
        case initiate(DatalinkCreateRequest)
    }
    
    func execute(type: DatalinkExecuteType, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let datalinkRepository = factory.makeDatalinkSnycRepository()
        let iamRepository = factory.makeIamRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let datalinkGetResult: Result<DatalinkGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch datalinkRepository.get(request: DatalinkGetRequest(uniqueId: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch datalinkRepository.create(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueId else { return .failure(PayByBankError.wrongLink) }
                    switch datalinkRepository.get(request: DatalinkGetRequest(uniqueId: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PayByBankHandlerProtocol, Error> = {
            switch datalinkGetResult {
            case .success(let response):
                guard let datalinkID = response.dataLink?.uniqueId,
                      let datalinkURL = URL(string: response.dataLink?.url ?? ""),
                      let redirectURL = URL(string: response.redirectionURL ?? "") else {
                          return .failure(PayByBankError.wrongLink)
                      }
                let handler = factory.makeDatalinkAPIHandler(uniqueID: datalinkID,
                                                            webViewURL: datalinkURL,
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
                let vc = self.factory.makeWebViewVC(handler: handler)
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
