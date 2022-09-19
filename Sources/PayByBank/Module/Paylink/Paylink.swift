//
//  PayByBank.swift
//  PayByBank
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import UIKit

/// Paylink API
/// - Note: The Ecospend Gateway presents Paylink as an alternative and easier form of Open Banking Instant Payment solution. Paylink provides you the option of downsizing the development effort for a PIS journey to a single endpoint integration. Paylink undertakes all of interaction in the payment user journey with your branding on display.
final class Paylink {
    
    private let factory: PaylinkFactoryProtocol
    
    internal init(factory: PaylinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension Paylink {
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of Paylink.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Paylink.
    ///     - url: Unique Paylink URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    ///     - viewController:  Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func open(uniqueID: String,
              url: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.open(uniqueID: uniqueID, webViewURL: url, redirectURL: redirectURL, viewController: viewController, completion: completion)
        }
    }
}

// MARK: - Logic
private extension Paylink {
    
    func open(uniqueID: String,
              webViewURL: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard webViewURL.isEcospendHost, !uniqueID.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        let handler = factory.makePaylinkHandler(uniqueID: uniqueID,
                                                 webViewURL: webViewURL,
                                                 redirectURL: redirectURL,
                                                 completionHandler: completion)
        
        DispatchQueue.main.async {
            let vc = self.factory.payByBankFactory.makeWebViewVC(handler: handler)
            let nc = UINavigationController(rootViewController: vc)
            viewController.present(nc, animated: true)
        }
    }
}
