//
//  VRPlinkFactory.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol VRPlinkFactoryProtocol {
    var payByBankFactory: PayByBankFactoryProtocol { get }
    func makeVRPlinkHandler(uniqueID: String,
                            webViewURL: URL,
                            redirectURL: URL,
                            completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol
}

class VRPlinkFactory: VRPlinkFactoryProtocol {
    
    let payByBankFactory: PayByBankFactoryProtocol
    
    init(payByBankFactory: PayByBankFactoryProtocol) {
        self.payByBankFactory = payByBankFactory
    }
}

extension VRPlinkFactory {
    
    func makeVRPlinkHandler(uniqueID: String,
                            webViewURL: URL,
                            redirectURL: URL,
                            completionHandler: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) -> PayByBankHandlerProtocol {
        return VRPlinkHandler(uniqueID: uniqueID, webViewURL: webViewURL, redirectURL: redirectURL, completionHandler: completionHandler)
    }
    
}
