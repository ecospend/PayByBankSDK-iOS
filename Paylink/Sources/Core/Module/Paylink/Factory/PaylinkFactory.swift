//
//  PaylinkFactory.swift
//  Paylink
//
//  Created by Yunus TÜR on 5.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol PaylinkFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makePaylinkRepository() -> PaylinkRepositoryProtocol
    func makePaylinkAPIHandler(uniqueID: String,
                               webViewURL: URL,
                               redirectURL: URL,
                               completionHandler: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) -> APIHandlerProtocol
}

class PaylinkFactory: PaylinkFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
}

extension PaylinkFactory {
    
    func makePaylinkRepository() -> PaylinkRepositoryProtocol {
        return PaylinkRepository(networking: payByBankFactory.makeNetworking())
    }
    
    func makePaylinkAPIHandler(uniqueID: String,
                               webViewURL: URL,
                               redirectURL: URL,
                               completionHandler: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) -> APIHandlerProtocol {
        return PaylinkAPIHandler(uniqueID: uniqueID, webViewURL: webViewURL, redirectURL: redirectURL, completionHandler: completionHandler)
    }
}
