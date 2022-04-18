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
            if let params = url.queryParameters,
               params["error"] == "user_canceled",
               params["datalink_id"] == uniqueID {
                handle(status: .canceled)
                return .cancel
            } else {
                return .cancel
            }
        case webViewURL.host:
            handle(status: .initiated)
            return .allow
        case PayByBankConstant.URLHost.ecospend, PayByBankConstant.URLHost.fca:
            UIApplication.shared.open(url)
            handle(status: .initiated)
            return .cancel
        default:
            UIApplication.shared.open(url)
            handle(status: .redirected)
            return .cancel
        }
    }
    
    func closeTapped() {
        handle(status: .canceled)
    }
}

// MARK: - Logic
private extension DatalinkHandler {
    
    func handle(status: PayByBankStatus) {
        if status != .initiated {
            delegate?.handler(self, isCompleted: true)
        }
        let result = PayByBankResult(uniqueID: uniqueID, status: status)
        completionHandler(.success(result))
    }
}
