//
//  BulkPayment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit

/// Bulk Payment API
/// - Note: A bulk payment is a payment created from a bulk list - so it's a payment to multiple beneficiaries from a single debit account. It will show as one debit on your bank statement. As with bulk lists, there are two types: standard domestic bulk payments and bulk Inter Account Transfers (IATs).
final class BulkPayment {
    
    private let factory: BulkPaymentFactoryProtocol
    
    internal init(factory: BulkPaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension BulkPayment {
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of BulkPayment Paylink.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Bulk Payment Paylink.
    ///     - url: Unique Bulk Payment Paylink URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
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
private extension BulkPayment {
    
    func open(uniqueID: String,
              webViewURL: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard webViewURL.isEcospendHost, !uniqueID.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        let handler = factory.makeBulkPaymentHandler(uniqueID: uniqueID,
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
