//
//  PayByBankHandler.swift
//  PayByBank
//
//  Created by Yunus TÜR on 11.03.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import WebKit

protocol PayByBankHandlerProtocol {
    var uniqueID: String { get }
    var webViewURL: URL { get }
    var redirectURL: URL { get }
    var completionHandler: (Result<PayByBankResult, PayByBankError>) -> Void { get }
    var delegate: PayByBankHandlerDelegate? { get set }
    func getWebViewDecision(url: URL?) -> WKNavigationActionPolicy
    func cancelLink()
}

protocol PayByBankHandlerDelegate: AnyObject {
    func handler(_ handler: PayByBankHandlerProtocol, isLoading: Bool)
    func handler(_ handler: PayByBankHandlerProtocol, isCompleted: Bool)
}
