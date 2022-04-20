//
//  VRPlink.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class VRPlink {
    
    private let factory: VRPlinkFactoryProtocol
    
    internal init(factory: VRPlinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
public extension VRPlink {
    
    /// Opens webview using with `uniqueID` of VRPlink
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of VRPlink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(uniqueID: String, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .open(uniqueID), viewController: viewController, completion: completion)
        }
    }
    
    /// Opens webview using with request model of VRPlink
    ///
    /// - Parameters:
    ///     - uniqueID: Request to create VRPlink
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: VRPlinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.execute(type: .initiate(request), viewController: viewController, completion: completion)
        }
    }
    
    /// Soft deletes VRPlink with given id
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of VRPlink.
    ///     - completion: It provides to handle result or error
    func delete(uniqueID: String, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.delete(request: VRPlinkDeleteRequest(uniqueID: uniqueID), completion: completion)
        }
    }
    
    /// Returns records of VRPlink
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of VRPlink.
    ///     - completion: It provides to handle result or error
    func getRecords(uniqueID: String, completion: @escaping (Result<VRPlinkGetRecordsResponse, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.getRecords(request: VRPlinkGetRecordsRequest(uniqueID: uniqueID), completion: completion)
        }
    }
}

// MARK: - Logic
private extension VRPlink {
    
    enum VRPlinkExecuteType {
        case open(String)
        case initiate(VRPlinkCreateRequest)
    }
    
    func execute(type: VRPlinkExecuteType, viewController: UIViewController, completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let vrplinkRepository = factory.makeVRPlinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        let vrplinkGetResult: Result<VRPlinkGetResponse, Error> = {
            switch type {
            case .open(let uniqueID):
                switch vrplinkRepository.getVRPlink(request: VRPlinkGetRequest(uniqueID: uniqueID)) {
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch vrplinkRepository.createVRPlink(request: request) {
                case .success(let createResponse):
                    guard let uniqueID = createResponse.uniqueID else { return .failure(PayByBankError.wrongLink) }
                    
                    switch vrplinkRepository.getVRPlink(request: VRPlinkGetRequest(uniqueID: uniqueID)) {
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PayByBankHandlerProtocol, Error> = {
            switch vrplinkGetResult {
            case .success(let response):
                guard let uniqueID = response.uniqueID,
                      let vrplinkURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PayByBankError.wrongLink)
                }
                let handler = factory.makeVRPlinkHandler(uniqueID: uniqueID,
                                                           webViewURL: vrplinkURL,
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
    
    func delete(request: VRPlinkDeleteRequest, completion: @escaping (Result<Bool, PayByBankError>) -> Void) {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let vrplinkRepository = factory.makeVRPlinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        switch vrplinkRepository.deleteVRPlink(request: request) {
        case .success(let isDeleted): return completion(.success(isDeleted))
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
    }
    
    func getRecords(request: VRPlinkGetRecordsRequest, completion: @escaping (Result<VRPlinkGetRecordsResponse, PayByBankError>) -> Void) {
        let iamRepository = factory.payByBankFactory.makeIamRepository()
        let vrplinkRepository = factory.makeVRPlinkRepository()
        
        switch iamRepository.getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
        
        switch vrplinkRepository.getVRPlinkRecords(request: request) {
        case .success(let response): return completion(.success(response))
        case .failure(let error): return completion(.failure(PayByBankError(error: error)))
        }
    }
}
