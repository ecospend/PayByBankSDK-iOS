//
//  DatalinkHandler.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import Foundation
import WebKit

class DatalinkHandler: PayByBankHandlerProtocol {
    
    let uniqueID: String
    let webViewURL: URL
    let redirectURL: URL
    let completionHandler: (Result<PayByBankResult, PayByBankError>) -> Void
    weak var delegate: PayByBankHandlerDelegate?
    
    init(uniqueID: String,
         webViewURL: URL,
         redirectURL: URL,
         completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        self.uniqueID = uniqueID
        self.webViewURL = webViewURL
        self.redirectURL = redirectURL
        self.completionHandler = completionHandler
    }
    
    func webViewDecision(url: URL?) -> WKNavigationActionPolicy {
        guard let url = url else { return .allow }
        switch url.host {
        case redirectURL.host:
            handle(status: .canceled)
            return .cancel
        case webViewURL.host:
            handle(status: .initiated)
            return .allow
        case PayByBankConstant.URLHost.ecospendFull, PayByBankConstant.URLHost.fca:
            handle(status: .initiated, url: url)
            return .cancel
        default:
            handle(status: .redirected, url: url)
            return .cancel
        }
    }
    
    func closeTapped() {
        handle(status: .canceled)
    }
}

// MARK: - Logic
private extension DatalinkHandler {
    
    func handle(status: PayByBankStatus, url: URL? = nil) {
        
        switch status {
        case .canceled, .redirected:
            delegate?.handler(self, isCompleted: true, url: url)
        case .initiated:
            delegate?.handler(self, isCompleted: false, url: url)
        }
        
        let result = PayByBankResult(uniqueID: uniqueID, status: status)
        completionHandler(.success(result))
    }
}
