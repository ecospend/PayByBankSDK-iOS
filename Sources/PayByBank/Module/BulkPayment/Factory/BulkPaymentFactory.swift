//
//  BulkPaymentFactory.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol BulkPaymentFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makeBulkPaymentRepository() -> BulkPaymentRepositoryProtocol
    func makeBulkPaymentHandler(uniqueID: String,
                                webViewURL: URL,
                                redirectURL: URL,
                                completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol
}

class BulkPaymentFactory: BulkPaymentFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
}

extension BulkPaymentFactory {
    
    func makeBulkPaymentRepository() -> BulkPaymentRepositoryProtocol {
        return BulkPaymentRepository(networking: payByBankFactory.makeNetworking())
    }
    
    func makeBulkPaymentHandler(uniqueID: String,
                                webViewURL: URL,
                                redirectURL: URL,
                                completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return BulkPaymentHandler(uniqueID: uniqueID, webViewURL: webViewURL, redirectURL: redirectURL, completionHandler: completionHandler)
    }
}
