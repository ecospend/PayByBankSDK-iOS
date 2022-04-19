//
//  FrPaymentFactory.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol FrPaymentFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makeFrPaymentRepository() -> FrPaymentRepositoryProtocol
    func makeFrPaymentHandler(uniqueID: String,
                              webViewURL: URL,
                              redirectURL: URL,
                              completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol
}

class FrPaymentFactory: FrPaymentFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
    
    func makeFrPaymentRepository() -> FrPaymentRepositoryProtocol {
        return FrPaymentRepository(networking: payByBankFactory.makeNetworking())
    }
    
    func makeFrPaymentHandler(uniqueID: String,
                              webViewURL: URL,
                              redirectURL: URL,
                              completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return FrPaymentHandler(uniqueID: uniqueID, webViewURL: webViewURL, redirectURL: redirectURL, completionHandler: completionHandler)
    }
}
