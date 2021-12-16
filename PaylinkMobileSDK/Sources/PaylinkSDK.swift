//
//  PaylinkSDK.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//

import Foundation
import UIKit

public class PaylinkSDK {
    
    private static let shared = PaylinkSDK()
    private init() { }
    
    public static func configure(clientID: String, clientSecret: String) {
        PaylinkState.Config.clientID = clientID
        PaylinkState.Config.clientSecret = clientSecret
        
        PaylinkSDK.shared.setupDI()
    }
    
    public static func open(uid: String, viewController: UIViewController, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(PaylinkState.Constant.paylinkHost)/?uid=\(uid)") else {
            completion(false)
            return
        }
        let vc = DIContainer.shared.resolve(type: WebViewVC.self, arguments: url)!
        let nc = UINavigationController(rootViewController: vc)
        viewController.present(nc, animated: true) {
            completion(true)
        }
    }
    
    public static func initiate(_ request: PaylinkCreateRequest, viewController: UIViewController, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void) {
        guard let clientID = PaylinkState.Config.clientID,
              let clietSecret = PaylinkState.Config.clientSecret else {
                  completion(.failure(NetworkError.unknown))
                  return
              }
        let tokenRequest = IamTokenRequest(clientID: clientID, clientSecret: clietSecret)
        let iamRepository = DIContainer.shared.resolve(type: IamRepositoryProtocol.self)!
        
        iamRepository.getToken(request: tokenRequest) { result in
            switch result {
            case .success:
                let paylinkRepository = DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!
                paylinkRepository.createPaylink(request: request) { result in
                    switch result {
                    case .success(let response):
                        guard let uid = response.uniqueID else {
                            completion(.failure(NetworkError.unknown))
                            return
                        }
                        PaylinkSDK.open(uid: uid, viewController: viewController) { isSuccess in
                            switch isSuccess {
                            case true:
                                completion(.success(response))
                            case false:
                                completion(.failure(NetworkError.unknown))
                            }
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

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
