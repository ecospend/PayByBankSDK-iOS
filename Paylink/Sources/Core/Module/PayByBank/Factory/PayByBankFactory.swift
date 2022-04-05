//
//  PayByBankFactory.swift
//  Paylink
//
//  Created by Yunus TÜR on 5.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol PayByBankFactoryProtocol {
    func makeNetworkSession() -> NetworkSessionProtocol
    func makeNetworking() -> NetworkingProtocol
    func makeIamRepository() -> IamRepositoryProtocol
    func makeWebViewVM(handler: APIHandlerProtocol) -> WebViewVM
    func makeWebViewVC(handler: APIHandlerProtocol) -> WebViewVC
}

class PayByBankFactory: PayByBankFactoryProtocol {
    
    func makeNetworkSession() -> NetworkSessionProtocol {
        return NetworkSession()
    }
    
    func makeNetworking() -> NetworkingProtocol {
        return Networking(networkSession: makeNetworkSession())
    }
    
    func makeIamRepository() -> IamRepositoryProtocol {
        return IamRepository(networking: makeNetworking())
    }
    
    func makeWebViewVM(handler: APIHandlerProtocol) -> WebViewVM {
        return WebViewVM(handler: handler)
    }
    
    func makeWebViewVC(handler: APIHandlerProtocol) -> WebViewVC {
        let vc = WebViewVC()
        vc.viewModel = makeWebViewVM(handler: handler)
        return vc
    }
}
