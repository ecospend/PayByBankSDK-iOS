//
//  Payment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 22.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit

/// Payment API
/// - Note: Domestic instant payments, international payments, and scheduled payments are all accomplished from the same /payments endpoint. The payment type is automatically identified by our system depending whether the debtor and creditor accounts are from different countries (for international payments), or whether a value has been set for the scheduled_for parameter (meaning a scheduled payment).
final class Payment {
    
    private let factory: PaymentFactoryProtocol
    
    internal init(factory: PaymentFactoryProtocol) {
        self.factory = factory
    }
}

// MARK: - API
extension Payment {
    
    /// Opens bank application or bank website using with `id` and`url (payment_url)` of Payment.
    ///
    /// - Note: This method does not require authentication.
    ///
    /// - Parameters:
    ///     - id: A system assigned unique identification for the Payment.
    ///     - url (payment_url): A unique and one time use only URL of the debtor's banking system. You will need to redirect PSU to this link in order the payment to proceed.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    func open(id: String,
              url: URL,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.open(id: id, paymentURL: url, completion: completion)
        }
    }
}

// MARK: - Logic
private extension Payment {
    
    func open(id: String,
              paymentURL: URL,
              completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        guard paymentURL.isEcospendHost, !id.isEmpty else {
            return completion(.failure(PayByBankError.wrongLink))
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.open(paymentURL)
            completion(.success(PayByBankResult(uniqueID: id, status: .redirected)))
        }
    }
}
