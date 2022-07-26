//
//  PayByBankFactory.swift
//  PayByBank
//
//  Created by Yunus TÜR on 5.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol PayByBankFactoryProtocol {
    func makeNetworkSession() -> NetworkSessionProtocol
    func makeNetworking() -> NetworkingProtocol
    func makeIamRepository() -> IamRepositoryProtocol
    func makeWebViewVM(handler: PayByBankHandlerProtocol) -> WebViewVM
    func makeWebViewVC(handler: PayByBankHandlerProtocol) -> WebViewVC
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
    
    func makeWebViewVM(handler: PayByBankHandlerProtocol) -> WebViewVM {
        return WebViewVM(handler: handler)
    }
    
    func makeWebViewVC(handler: PayByBankHandlerProtocol) -> WebViewVC {
        let vc = WebViewVC()
        vc.viewModel = makeWebViewVM(handler: handler)
        return vc
    }
}
