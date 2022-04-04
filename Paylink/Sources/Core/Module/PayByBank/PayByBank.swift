//
//  PayByBank.swift
//  Paylink
//
//  Created by Yunus TÜR on 4.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class PayByBank {
    private init() { }
}

// MARK: - API
public extension PayByBank {
    
    /// - Parameters:
    ///     - environment: Enum "Sandbox" "Production"
    ///     - clientID: Unique identification string assigned to the client by our system
    ///     - clientSecret: Secret string assigned to the client by our system
    static func configure(environment: PaylinkEnvironment, clientID: String, clientSecret: String) {
        // Configuration
        PaylinkState.Config.environment = environment
        PaylinkState.Config.clientID = clientID
        PaylinkState.Config.clientSecret = clientSecret
        // Dependency Injection
        PayByBank.setupDI()
    }
    
    static var paylink: Paylink {
        return Paylink(tokenClosure: { getToken() })
    }
}

// MARK: - Token
extension PayByBank {
    
    static func getToken() -> Result<IamTokenResponse, Error> {
        // Configure
        guard let clientID = PaylinkState.Config.clientID,
              let clietSecret = PaylinkState.Config.clientSecret else {
           return .failure(PaylinkError.notConfigured)
        }
        
        // Service Call
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<IamTokenResponse, Error>!
        let iamRepository = DIContainer.shared.resolve(type: IamRepositoryProtocol.self)!
        
        let request = IamTokenRequest(clientID: clientID, clientSecret: clietSecret)
        iamRepository.getToken(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}

// MARK: - Dependency Injection
extension PayByBank {
    
    static func setupDI() {
        DIContainer.shared.register(type: NetworkSessionProtocol.self, scope: .singleton) { _ in
            NetworkSession()
        }
        
        DIContainer.shared.register(type: NetworkingProtocol.self, scope: .singleton) { _ in
            Networking(networkSession: DIContainer.shared.resolve(type: NetworkSessionProtocol.self)!)
        }
        
        DIContainer.shared.register(type: IamRepositoryProtocol.self, scope: .singleton) { _ in
            IamRepository(networking: DIContainer.shared.resolve(type: NetworkingProtocol.self)!)
        }
        
        DIContainer.shared.register(type: WebViewVM.self, scope: .transient) { argument in
            let vm = WebViewVM(handler: argument as! PaylinkAPIHandler,
                               paylinkRepository: DIContainer.shared.resolve(type: PaylinkRepositoryProtocol.self)!)
            return vm
        }
        
        DIContainer.shared.register(type: WebViewVC.self, scope: .transient) { argument in
            let vc = WebViewVC()
            vc.viewModel = DIContainer.shared.resolve(type: WebViewVM.self, arguments: argument as! PaylinkAPIHandler)!
            return vc
        }
    }
    
    static func resetDI() {
        DIContainer.shared.reset()
    }
}
