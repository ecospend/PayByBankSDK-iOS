//
//  PaymentCreateRefundRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCreateRefundRequest
/// Request model to create refund of Payment.
public struct PaymentCreateRefundRequest: Codable {
    
    /// Unique id value to query Payment.
    public let id: String
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String
    
    /// Payment amount in decimal format.
    /// - Warning: This amount can not exceed original payment amount.
    public let amount: Decimal
    
    /// Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Note: Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String
    
    /// Represents the refund account information structure of that is returned by the bank.
    public let refundAccount: PayByBankAccountRequest
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bankID = "bank_id"
        case amount = "amount"
        case currency = "currency"
        case description = "description"
        case reference = "reference"
        case redirectURL = "redirect_url"
        case refundAccount = "refund_account"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - id: Unique id value to query Payment.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - amount: Payment amount in decimal format.
    ///     - currency: Instance’s `PayByBankCurrency`, which is currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - refundAccount:  Instance’s `PayByBankAccountRequest`, which represents the refund account information structure of that is returned by the bank.
    public init(id: String,
                bankID: String,
                amount: Decimal,
                currency: PayByBankCurrency,
                description: String? = nil,
                reference: String,
                redirectURL: String,
                refundAccount: PayByBankAccountRequest) {
        self.id = id
        self.bankID = bankID
        self.amount = amount
        self.currency = currency
        self.description = description
        self.reference = reference
        self.redirectURL = redirectURL
        self.refundAccount = refundAccount
    }
}
