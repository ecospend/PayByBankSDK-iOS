//
//  Datalink.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import Foundation
import UIKit

/// Datalink API
/// - Note: Datalink is a whitelabel consent journey solution provided by Ecospend that downsizes the required implementation for the consent journey to a single endpoint integration. By making a single call to /datalink endpoint you will be able to initiate the consent journey.
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
    
    /// Creates Datalink
    ///
    /// - Parameters:
    ///     - request: Request to create Datalink
    ///     - completion: It provides to handle result or error
    func createDatalink(request: DatalinkCreateRequest, completion: @escaping (Result<DatalinkCreateResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.createDatalink(request: request))
        }
    }
    
    /// Gets Datalink detail
    ///
    /// - Parameters:
    ///     - request: Request to get Datalink detail
    ///     - completion: It provides to handle result or error
    func getDatalink(request: DatalinkGetRequest, completion: @escaping (Result<DatalinkGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getDatalink(request: request))
        }
    }
    
    /// Deletes the Datalink with given id.
    ///
    /// - Parameters:
    ///     - request: Request to deactivate Datalink
    ///     - completion: It provides to handle result or error
    func deleteDatalink(request: DatalinkDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.deleteDatalink(request: request))
        }
    }
    
    /// Returns datalink with given `consentID`
    ///
    /// - Parameters:
    ///     - request: Request to get Datalink of a consent
    ///     - completion: It provides to handle result or error
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest, completion: @escaping (Result<DatalinkGetResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            completion(self.getDatalinkOfConsent(request: request))
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
                switch datalinkRepository.getDatalink(request: DatalinkGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch datalinkRepository.createDatalink(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch datalinkRepository.getDatalink(request: DatalinkGetRequest(uniqueID: uniqueID)) {
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
    
    func createDatalink(request: DatalinkCreateRequest) -> Result<DatalinkCreateResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch datalinkRepository.createDatalink(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func getDatalink(request: DatalinkGetRequest) -> Result<DatalinkGetResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch datalinkRepository.getDatalink(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func deleteDatalink(request: DatalinkDeleteRequest) -> Result<Bool, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch datalinkRepository.deleteDatalink(request: request) {
        case .success(let isDeleted): return .success(isDeleted)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
    
    func getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest) -> Result<DatalinkGetResponse, PayByBankError> {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let datalinkRepository = factory.makeDatalinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
        
        switch datalinkRepository.getDatalinkOfConsent(request: request) {
        case .success(let response): return .success(response)
        case .failure(let error): return .failure(PayByBankError(error: error))
        }
    }
}
