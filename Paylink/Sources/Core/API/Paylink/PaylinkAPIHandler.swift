//
//  PaylinkAPIHandler.swift
//  Paylink
//
//  Created by Yunus TÜR on 11.03.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import WebKit

class PaylinkAPIHandler: APIHandlerProtocol {
    
    let uniqueID: String
    let webViewURL: URL
    let redirectURL: URL
    let completionHandler: (Result<PaylinkResult, PaylinkError>) -> Void
    weak var delegate: APIHandlerDelegate?
    
    private let paylinkRepository: PaylinkRepositoryProtocol
    
    init(uniqueID: String,
         webViewURL: URL,
         redirectURL: URL,
         paylinkRepository: PaylinkRepositoryProtocol,
         completionHandler: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        self.uniqueID = uniqueID
        self.webViewURL = webViewURL
        self.redirectURL = redirectURL
        self.completionHandler = completionHandler
        self.paylinkRepository = paylinkRepository
    }
}

// MARK: - APIHandlerProtocol
extension PaylinkAPIHandler {
    
    func getWebViewDecision(url: URL?) -> WKNavigationActionPolicy {
        guard let url = url else { return .allow }
        
        switch url.host {
        case redirectURL.host:
            if let params = url.queryParameters,
               params["error"] == "user_canceled",
               params["paylink_id"] == uniqueID {
                handle(status: .canceled)
                return .cancel
            } else {
                return .cancel
            }
        case webViewURL.host:
            handle(status: .initiated)
            return .allow
        default:
            UIApplication.shared.open(url)
            handle(status: .redirected)
            return .cancel
        }
    }
    
    func cancelLink() {
        handle(status: .canceled)
    }
}

// MARK: - Logic
private extension PaylinkAPIHandler {
    
    func handle(status: PaylinkStatus) {
        if status != .initiated {
            delegate?.handler(self, isCompleted: true)
        }
        let result = PaylinkResult(uniqueID: uniqueID, status: status)
        completionHandler(.success(result))
    }
}
