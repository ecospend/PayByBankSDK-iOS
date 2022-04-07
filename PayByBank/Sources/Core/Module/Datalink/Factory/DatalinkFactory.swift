//
//  DatalinkFactory.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import Foundation

protocol DatalinkFactoryProtocol {
    func makeNetworkSession() -> NetworkSessionProtocol
    func makeNetworking() -> NetworkingProtocol
    func makeIamRepository() -> IamRepositoryProtocol
    func makeDatalinkAsnycRepository() -> DatalinkRepositoryAsyncProtocol
    func makeDatalinkSnycRepository() -> DatalinkRepositorySyncProtocol
    func makeWebViewVM(handler: PayByBankHandlerProtocol) -> WebViewVM
    func makeWebViewVC(handler: PayByBankHandlerProtocol) -> WebViewVC
    func makeDatalinkAPIHandler(uniqueID: String,
                                webViewURL: URL,
                                redirectURL: URL,
                                completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol
}

class DatalinkFactory: DatalinkFactoryProtocol {
    
    func makeNetworkSession() -> NetworkSessionProtocol {
        return NetworkSession()
    }
    
    func makeNetworking() -> NetworkingProtocol {
        return Networking(networkSession: makeNetworkSession())
    }
    
    func makeIamRepository() -> IamRepositoryProtocol {
        return IamRepository(networking: makeNetworking())
    }
    
    func makeDatalinkAsnycRepository() -> DatalinkRepositoryAsyncProtocol {
        return DatalinkRepository(networking: makeNetworking())
    }
    
    func makeDatalinkSnycRepository() -> DatalinkRepositorySyncProtocol {
        return DatalinkRepository(networking: makeNetworking())
    }
    
    func makeWebViewVM(handler: PayByBankHandlerProtocol) -> WebViewVM {
        return WebViewVM(handler: handler)
    }
    
    func makeWebViewVC(handler: PayByBankHandlerProtocol) -> WebViewVC {
        let vc = WebViewVC()
        vc.viewModel = makeWebViewVM(handler: handler)
        return vc
    }    
    
    func makeDatalinkAPIHandler(uniqueID: String, webViewURL: URL, redirectURL: URL, completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return PaylinkHandler(uniqueID: uniqueID,
                              webViewURL: webViewURL,
                              redirectURL: redirectURL,
                              completionHandler: completionHandler)
    }
}
