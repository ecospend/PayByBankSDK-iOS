//
//  VRPlink.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

/// VRPlink (Variable Recurring Payments) API
/// - Note: Variable Recurring Payments (VRPs) let customers safely connect authorised payments providers to their bank account so that they can make payments on the customer’s behalf, in line with agreed limits. VRPs offer more control and transparency than existing alternatives, such as Direct Debit payments.
final class VRPlink {
    
    private let factory: VRPlinkFactoryProtocol
    
    internal init(factory: VRPlinkFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension VRPlink {
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of VRPlink.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the VRPlink.
    ///     - url: Unique VRPlink URL that you will need to redirect PSU in order the payment to proceed.
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
private extension VRPlink {
    
    func open(uniqueID: String,
              webViewURL: URL,
              redirectURL: URL,
              viewController: UIViewController,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard webViewURL.isEcospendHost, !uniqueID.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        let handler = factory.makeVRPlinkHandler(uniqueID: uniqueID,
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
