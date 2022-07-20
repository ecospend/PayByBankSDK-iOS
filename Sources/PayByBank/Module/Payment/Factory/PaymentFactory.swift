//
//  PaymentFactory.swift
//  PayByBank
//
//  Created by Yunus TÜR on 22.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol PaymentFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makePaymentRepository() -> PaymentRepositoryProtocol
    func makePaymentHandler(uniqueID: String,
                            webViewURL: URL,
                            redirectURL: URL,
                            completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol 
}

class PaymentFactory: PaymentFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
}

extension PaymentFactory {
    
    func makePaymentRepository() -> PaymentRepositoryProtocol {
        return PaymentRepository(networking: payByBankFactory.makeNetworking())
    }
    
    func makePaymentHandler(uniqueID: String,
                            webViewURL: URL,
                            redirectURL: URL,
                            completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return PaymentHandler(uniqueID: uniqueID, webViewURL: webViewURL, redirectURL: redirectURL, completionHandler: completionHandler)
    }
}
