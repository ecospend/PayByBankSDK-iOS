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
    
    public static let shared = Paylink()
    
    private lazy var iamRepository: IamRepositoryProtocol = DIContainer.shared.resolve(type: IamRepositoryProtocol.self)!
    private lazy var paylinkRepository: PaylinkRepositoryProtocol = DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!
    
    private init() {
        setupDI()
    }
}

// MARK: - API
public extension Paylink {
    
    func configure(environment: PaylinkEnvironment, clientID: String, clientSecret: String) {
        PaylinkState.Config.environment = environment
        PaylinkState.Config.clientID = clientID
        PaylinkState.Config.clientSecret = clientSecret
    }
    
    func open(paylinkID: String, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        execute(type: .open(paylinkID), viewController: viewController, completion: completion)
    }
    
    func initiate(request: PaylinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        execute(type: .initiate(request), viewController: viewController, completion: completion)
    }
}

// MARK: - Logic
private extension Paylink {
    
    enum PaylinkExecuteType {
        case open(String)
        case initiate(PaylinkCreateRequest)
    }
    
    func execute(type: PaylinkExecuteType, viewController: UIViewController, completion: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        let dispatchBackgroundQueue = DispatchQueue.global()
        let dispatchGroup = DispatchGroup()
        
        dispatchBackgroundQueue.async { [weak self] in
            guard let self = self else {
                return DispatchQueue.main.async { completion(.failure(PaylinkError.unknown(nil))) }
            }
            
            // Generate WebViewSceneModel
            let sceneResult: Result<WebViewSceneModel, Error> = {
                
                // Completion of GetPaylink
                let getPaylinkCompletion: (String?) -> Result<WebViewSceneModel, Error> = { paylinkID in
                    guard let paylinkID = paylinkID else { return .failure(PaylinkError.wrongPaylink) }
                    
                    switch self.getPaylink(inGroup: dispatchGroup, request: PaylinkGetRequest(paylinkID: paylinkID)) {
                    case .success(let response):
                        guard let paylinkID = response.uniqueID,
                              let paylinkURL = URL(string: "\(PaylinkState.Config.environment.paylinkURL)/?uid=\(paylinkID)"),
                              let redirectURL = URL(string: response.redirectURL ?? "") else {
                                  return .failure(PaylinkError.wrongPaylink)
                              }
                        return .success(WebViewSceneModel(paylinkID: paylinkID,
                                                          paylinkURL: paylinkURL,
                                                          paylinkRedirectURL: redirectURL,
                                                          completionHandler: completion,
                                                          dismissHandler: { self.resetDI() }))
                    case .failure(let error):
                        return .failure(PaylinkError(error: error))
                    }
                }
                
                // Get Access Token
                switch self.getToken(inGroup: dispatchGroup){
                case .success: break
                case .failure(let error): return .failure(PaylinkError(error: error))
                }
                
                // Handle for type
                switch type {
                case .open(let paylinkID):
                    // Get Paylink
                    return getPaylinkCompletion(paylinkID)
                case .initiate(let request):
                    // Create Paylink
                    switch self.createPaylink(inGroup: dispatchGroup, request: request) {
                    case .success(let response):
                        // Get Paylink
                        return getPaylinkCompletion(response.uniqueID)
                    case .failure(let error):
                        return .failure(PaylinkError(error: error))
                    }
                }
            }()
            
            switch sceneResult {
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
}

// MARK: - DI
private extension Paylink {
    
    func setupDI() {
        DIContainer.shared.register(type: NetworkSessionProtocol.self, scope: .singleton) { _ in
            NetworkSession()
        }
        
        DIContainer.shared.register(type: NetworkingProtocol.self, scope: .singleton) { _ in
            Networking(networkSession: DIContainer.shared.resolve(type: NetworkSessionProtocol.self)!)
        }
        
        DIContainer.shared.register(type: IamRepositoryProtocol.self, scope: .transient) { _ in
            IamRepository(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
        
        DIContainer.shared.register(type: PaylinkRepositoryProtocol.self, scope: .transient) { _ in
            PaylinkRepository(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
        
        DIContainer.shared.register(type: WebViewVM.self, scope: .transient) { argument in
            let vm = WebViewVM(paylinkRepository: DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!,
                               model: argument as! WebViewSceneModel)
            return vm
        }
        
        DIContainer.shared.register(type: WebViewVC.self, scope: .transient) { argument in
            let vc = WebViewVC()
            vc.viewModel = DIContainer.shared.resolve(type: WebViewVM.self, arguments: argument as! WebViewSceneModel)!
            return vc
        }
    }
    
    func resetDI() {
        DIContainer.shared.reset()
    }
}

// MARK: - Networking
private extension Paylink {
    
    func getToken(inGroup group: DispatchGroup) -> Result<IamTokenResponse, Error> {
        guard let clientID = PaylinkState.Config.clientID,
              let clietSecret = PaylinkState.Config.clientSecret else {
                  return .failure(PaylinkError.notConfigured)
              }
        
        let request = IamTokenRequest(clientID: clientID, clientSecret: clietSecret)
        
        var result: Result<IamTokenResponse, Error>!
        group.enter()
        iamRepository.getToken(request: request) { _result in
            result = _result
            group.leave()
        }
        group.wait()
        return result
    }
    
    func createPaylink(inGroup group: DispatchGroup, request: PaylinkCreateRequest) -> Result<PaylinkCreateResponse, Error> {
        var result: Result<PaylinkCreateResponse, Error>!
        group.enter()
        paylinkRepository.createPaylink(request: request) { _result in
            result = _result
            group.leave()
        }
        group.wait()
        return result
    }
    
    func getPaylink(inGroup group: DispatchGroup, request: PaylinkGetRequest) -> Result<PaylinkGetResponse, Error> {
        var result: Result<PaylinkGetResponse, Error>!
        group.enter()
        paylinkRepository.getPaylink(request: request) { _result in
            result = _result
            group.leave()
        }
        group.wait()
        return result
    }
}
