//
//  DatalinkFactory.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import Foundation

protocol DatalinkFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makeDatalinkHandler(uniqueID: String,
                             webViewURL: URL,
                             redirectURL: URL,
                             completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol
}

class DatalinkFactory: DatalinkFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
}

extension DatalinkFactory {
    
    func makeDatalinkHandler(uniqueID: String, webViewURL: URL, redirectURL: URL, completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return DatalinkHandler(uniqueID: uniqueID,
                              webViewURL: webViewURL,
                              redirectURL: redirectURL,
                              completionHandler: completionHandler)
    }
}
