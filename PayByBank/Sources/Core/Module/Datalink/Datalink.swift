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
    
    /// Opens webview using with `uniqueID` of datalink
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
    
    /// Soft deletes Datalink with given id
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of Datalink.
    ///     - completion: It provides to handle result or error
    func delete(uniqueID: String, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.delete(request: DatalinkDeleteRequest(uniqueID: uniqueID), completion: completion)
        }
    }
    
    /// Returns datalink with given `consentID`
    ///
    /// - Parameters:
    ///     - consentID: Unique id value of Datalink.
    ///     - completion: It provides to handle result or error
    func getConsentDatalink(consentID: String, completion: @escaping (Result<DatalinkGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.getConsentDatalink(request: DatalinkGetConsentDatalinkRequest(consentID: consentID), completion: completion)
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
        
        let datalinkRepository = factory.makeDatalinkRepository()
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let datalinkGetResult: Result<DatalinkGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch datalinkRepository.get(request: DatalinkGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch datalinkRepository.create(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch datalinkRepository.get(request: DatalinkGetRequest(uniqueID: uniqueID)) {
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
                guard let datalinkID = response.datalink?.uniqueID,
                      let datalinkURL = URL(string: response.datalink?.url ?? ""),
                      let redirectURL = URL(string: response.redirectionURL ?? "") else {
                          
                          return .failure(PayByBankError.wrongLink)
                      }
                let handler = factory.makeDatalinkHandler(uniqueID: datalinkID,
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
    
    func delete(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        switch datalinkRepository.delete(request: request) {
        case .success(let isDeleted): return completion(.success(isDeleted))
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
    }
    
    func getConsentDatalink(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, PayByBankError>) -> Void) {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        switch datalinkRepository.getConsentDatalink(request: request) {
        case .success(let response): return completion(.success(response))
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
    }
}
