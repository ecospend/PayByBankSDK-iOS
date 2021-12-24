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
    
    func open(uid: String, viewController: UIViewController, completion: @escaping (Result<[PaylinkPaymentGetResponse], Error>) -> Void) {
        
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
            
            guard let url = URL(string: "\(PaylinkState.Config.environment.paylinkURL)/?uid=\(uid)") else {
                return complete(.failure(NetworkError.unknown))
            }
            
            let request = PaylinkPaymentGetRequest(paylinkID: uid)
            let result = self.getPayments(inGroup: dispatchGroup, request: request)
            
            switch result {
            case .success(let payments):
                DispatchQueue.main.async {
                    let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: url)!
                    let nc = UINavigationController(rootViewController: vc)
                    viewController.present(nc, animated: true) {
                        complete(.success(payments))
                    }
                }
            case .failure(let error):
                complete(.failure(error))
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
                  let uid = createResponse.uniqueID,
                  let url = URL(string: createResponse.paylinkURL ?? "") else {
                      return complete(.failure(NetworkError.unknown))
                  }
            
            let request = PaylinkPaymentGetRequest(paylinkID: uid)
            let result = self.getPayments(inGroup: dispatchGroup, request: request)
            
            switch result {
            case .success(let payments):
                DispatchQueue.main.async {
                    let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: url)!
                    let nc = UINavigationController(rootViewController: vc)
                    viewController.present(nc, animated: true) {
                        complete(.success(payments))
                    }
                }
            case .failure(let error):
                complete(.failure(error))
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
        
        DIContainer.shared.register(type: WebViewVC.self, scope: .transient) { argument in
            let vc = WebViewVC()
            vc.paylink = (argument as! URL)
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
    
    func getPayments(inGroup group: DispatchGroup, request: PaylinkPaymentGetRequest) -> Result<[PaylinkPaymentGetResponse], Error> {
        var result: Result<[PaylinkPaymentGetResponse], Error>!
        group.enter()
        paylinkRepository.getPayments(request: request) { _result in
            result = _result
            group.leave()
        }
        group.wait()
        return result
    }
}
