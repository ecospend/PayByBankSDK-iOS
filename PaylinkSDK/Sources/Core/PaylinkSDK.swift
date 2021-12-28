//
//  PaylinkSDK.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//

import Foundation
import UIKit

public final class PaylinkSDK {
    
    public static let shared = PaylinkSDK()
    
    private lazy var iamRepository: IamRepositoryProtocol = DIContainer.shared.resolve(type: IamRepositoryProtocol.self)!
    private lazy var paylinkRepository: PaylinkRepositoryProtocol = DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!
    
    private init() {
        setupDI()
    }
}

// MARK: - API
public extension PaylinkSDK {
    
    func configure(_ environment: PaylinkEnvironment, clientID: String, clientSecret: String) {
        PaylinkState.Config.environment = environment
        PaylinkState.Config.clientID = clientID
        PaylinkState.Config.clientSecret = clientSecret
    }
    
    func open(paylinkID: String, viewController: UIViewController, completion: @escaping (Result<[PaylinkPaymentGetResponse], Error>) -> Void) {
        
        let dispatchBackgroundQueue = DispatchQueue.global()
        let dispatchGroup = DispatchGroup()
        
        let complete: (Result<[PaylinkPaymentGetResponse], Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        dispatchBackgroundQueue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else {
                return complete(.failure(NetworkError.unknown))
            }
            
            if case .failure(let error) = self.getToken(inGroup: dispatchGroup) {
                return complete(.failure(error))
            }
            
            guard let paylinkURL = URL(string: "\(PaylinkState.Config.environment.paylinkURL)/?uid=\(paylinkID)") else {
                return complete(.failure(NetworkError.unknown))
            }
            
            let request = PaylinkGetRequest(paylinkID: paylinkID)
            let result = self.getPaylink(inGroup: dispatchGroup, request: request)
            
            if case .failure(let error) = result {
                return complete(.failure(error))
            }
            
            if case .success(let paylink) = result,
               let redirectURL = URL(string: paylink.redirectURL ?? "") {
                DispatchQueue.main.async {
                    let model = WebViewSceneModel(paylinkID: paylinkID,
                                                  paylinkURL: paylinkURL,
                                                  paylinkRedirectURL: redirectURL,
                                                  paymentsCompletionHandler: completion)
                    let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: model)!
                    let nc = UINavigationController(rootViewController: vc)
                    viewController.present(nc, animated: true)
                }
            }
        }
    }
    
    func initiate(request: PaylinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<[PaylinkPaymentGetResponse], Error>) -> Void) {
        
        let dispatchBackgroundQueue = DispatchQueue.global()
        let dispatchGroup = DispatchGroup()
        
        let complete: (Result<[PaylinkPaymentGetResponse], Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        dispatchBackgroundQueue.async { [weak self] in
            guard let self = self else {
                return complete(.failure(NetworkError.unknown))
            }
            
            if case .failure(let error) = self.getToken(inGroup: dispatchGroup) {
                return complete(.failure(error))
            }
            
            let createResult = self.createPaylink(inGroup: dispatchGroup, request: request)
            
            if case .failure(let error) = createResult {
                return complete(.failure(error))
            }
            
            guard case .success(let createResponse) = createResult,
                  let paylinkID = createResponse.uniqueID,
                  let paylinkURL = URL(string: createResponse.paylinkURL ?? "") else {
                      return complete(.failure(NetworkError.unknown))
                  }
            
            let request = PaylinkGetRequest(paylinkID: paylinkID)
            let result = self.getPaylink(inGroup: dispatchGroup, request: request)
            
            if case .failure(let error) = result {
                return complete(.failure(error))
            }
            
            if case .success(let paylink) = result,
               let redirectURL = URL(string: paylink.redirectURL ?? "") {
                DispatchQueue.main.async {
                    let model = WebViewSceneModel(paylinkID: paylinkID,
                                                  paylinkURL: paylinkURL,
                                                  paylinkRedirectURL: redirectURL,
                                                  paymentsCompletionHandler: completion)
                    let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: model)!
                    let nc = UINavigationController(rootViewController: vc)
                    viewController.present(nc, animated: true)
                }
            }
        }
    }
}

// MARK: - Setup
private extension PaylinkSDK {
    
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
}

// MARK: - Networking
private extension PaylinkSDK {
    
    func getToken(inGroup group: DispatchGroup) -> Result<IamTokenResponse, Error> {
        guard let clientID = PaylinkState.Config.clientID,
              let clietSecret = PaylinkState.Config.clientSecret else {
                  return .failure(NetworkError.unknown)
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
