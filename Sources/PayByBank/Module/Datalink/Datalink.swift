//
//  Datalink.swift
//  PayByBank
//
//  Created by Berk Akkerman on 7.04.2022.
//

import UIKit

/// Datalink API
/// - Note: Datalink is a whitelabel consent journey solution provided by Ecospend that downsizes the required implementation for the consent journey to a single endpoint integration. By making a single call to /datalink endpoint you will be able to initiate the consent journey.
final class Datalink {
    
    private let factory: DatalinkFactoryProtocol
    
    internal init(factory: DatalinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension Datalink {
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of Datalink.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Datalink.
    ///     - url: Unique Datalink URL that you will need to redirect PSU in order the account access consent to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of account access process.
    ///     - viewController: Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func open(uniqueID: String,
              url: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.open(uniqueID: uniqueID,
                      webViewURL: url,
                      redirectURL: redirectURL,
                      viewController: viewController,
                      completion: completion)
        }
    }
}

// MARK: - Logic
private extension Datalink {
    
    func open(uniqueID: String,
              webViewURL: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard webViewURL.isEcospendHost, !uniqueID.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        let handler = factory.makeDatalinkHandler(uniqueID: uniqueID,
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
