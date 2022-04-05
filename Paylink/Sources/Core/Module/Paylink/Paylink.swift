//
//  Paylink.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class Paylink {
    
    private var getToken: () -> Result<IamTokenResponse, Error>
    
    internal init(tokenClosure: @escaping () -> Result<IamTokenResponse, Error>) {
        self.getToken = tokenClosure
        setupDI()
    }
}

// MARK: - API
public extension Paylink {
    
    /// - Parameters:
    ///     - paylinkID: Unique id value of paylink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func open(paylinkID: String, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        PaylinkState.GCD.dispatchQueue.async {
            self.execute(type: .open(paylinkID), viewController: viewController, completion: completion)
        }
        
    }
    
    /// - Parameters:
    ///     - request: Request to create paylink
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    func initiate(request: PaylinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        PaylinkState.GCD.dispatchQueue.async {
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
    
    func execute(type: PaylinkExecuteType, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        
        switch getToken() {
        case .success: break
        case .failure(let error): return completion(.failure(PaylinkError(error: error)))
        }
        
        let paylinkGetResult: Result<PaylinkGetResponse, Error> = {
            switch type {
            case .open(let paylinkID):
                switch getPaylink(request: PaylinkGetRequest(paylinkID: paylinkID)){
                case .success(let response): return .success(response)
                case .failure(let error): return .failure(error)
                }
            case .initiate(let request):
                switch createPaylink(request: request) {
                case .success(let createResponse):
                    guard let paylinkID = createResponse.uniqueID else { return .failure(PaylinkError.wrongPaylink) }
                    
                    switch getPaylink(request: PaylinkGetRequest(paylinkID: paylinkID)){
                    case .success(let response): return .success(response)
                    case .failure(let error): return .failure(error)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }
        }()
        
        let handlerResult: Result<PaylinkAPIHandler, Error> = {
            switch paylinkGetResult {
            case .success(let response):
                guard let paylinkID = response.uniqueID,
                      let paylinkURL = URL(string: response.url ?? ""),
                      let redirectURL = URL(string: response.redirectURL ?? "") else {
                    return .failure(PaylinkError.wrongPaylink)
                }
                let handler = PaylinkAPIHandler(uniqueID: paylinkID,
                                                webViewURL: paylinkURL,
                                                redirectURL: redirectURL,
                                                paylinkRepository: DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!) { [weak self] result in
                    if case .success(let paylinkResult) = result, paylinkResult.status != .initiated {
                        self?.resetDI()
                    }
                    completion(result)
                }
                return .success(handler)
            case .failure(let error):
                return .failure(error)
            }
        }()
        
        switch handlerResult {
        case .success(let model):
            DispatchQueue.main.async {
                let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: model)!
                let nc = UINavigationController(rootViewController: vc)
                viewController.present(nc, animated: true)
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(.failure(PaylinkError(error: error)))
            }
        }
    }
}

// MARK: - DI
private extension Paylink {
    
    func setupDI() {
        DIContainer.shared.register(type: PaylinkRepositoryProtocol.self, scope: .singleton) { _ in
            PaylinkRepository(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
    }
    
    func resetDI() {
        DIContainer.shared.reset()
    }
}

// MARK: - Networking
private extension Paylink {
    
    func createPaylink(request: PaylinkCreateRequest) -> Result<PaylinkCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaylinkCreateResponse, Error> = .failure(PaylinkError.unknown(nil))
        let paylinkRepository = DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!
        
        paylinkRepository.createPaylink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getPaylink(request: PaylinkGetRequest) -> Result<PaylinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<PaylinkGetResponse, Error> = .failure(PaylinkError.unknown(nil))
        let paylinkRepository = DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!
        
        paylinkRepository.getPaylink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
