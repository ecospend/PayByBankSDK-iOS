//
//  APIHandler.swift
//  Paylink
//
//  Created by Yunus TÜR on 11.03.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import WebKit

protocol APIHandlerProtocol {
    var uniqueID: String { get }
    var webViewURL: URL { get }
    var redirectURL: URL { get }
    var completionHandler: (Result<PaylinkResult, PaylinkError>) -> Void { get }
    var delegate: APIHandlerWebViewProtocol? { get set }
    func getWebViewDecision(url: URL?) -> WKNavigationActionPolicy
    func checkStatus()
    func deleteLink()
}

protocol APIHandlerWebViewProtocol: NSObject {
    func handler(_ handler: APIHandlerProtocol, isLoading: Bool)
    func handler(_ handler: APIHandlerProtocol, isCompleted: Bool)
}
