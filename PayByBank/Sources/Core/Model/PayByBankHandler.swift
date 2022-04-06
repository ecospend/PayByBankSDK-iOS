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
    
    /// Identifier of the link
    var uniqueID: String { get }
    
    /// URL thats is used to open webview
    var webViewURL: URL { get }
    
    /// URL that provides to redirect result
    var redirectURL: URL { get }
    
    /// Closure that returns result or error of the process
    var completionHandler: (Result<PayByBankResult, PayByBankError>) -> Void { get }
    
    /// Protocol that controls completion or loading of webview
    var delegate: PayByBankHandlerDelegate? { get set }
    
    /// Returns decision of webview
    func webViewDecision(url: URL?) -> WKNavigationActionPolicy
    
    /// Event that handles tapping close button at webview
    func closeTapped()
}

protocol PayByBankHandlerDelegate: AnyObject {
    
    /// Event that returns loading status for webview
    func handler(_ handler: PayByBankHandlerProtocol, isLoading: Bool)
    
    /// Event that returns completion status for webview
    func handler(_ handler: PayByBankHandlerProtocol, isCompleted: Bool)
}
