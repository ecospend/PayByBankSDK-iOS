//
//  PaymentCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCreateRequest
public struct PaymentCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the payment journey.
    /// - Warning: This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    public let redirectURL: String
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String
    
    /// Payment amount in decimal format.
    public let amount: Decimal
    
    /// Currency code  in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Note: Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountRequest
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountRequest?
    
    /// Additional fields for a payment that can be mandotary for specific cases.
    public let paymentOption: PaymentOption?
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Note: Enum: "Auto" "Domestic" "DomesticScheduled" "International" "InternationalScheduled"
    public let paymentType: PaymentType?
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case bankID = "bank_id"
        case amount = "amount"
        case currency = "currency"
        case description = "description"
        case reference = "reference"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case paymentOption = "payment_option"
        case paymentType = "payment_type"
    }
    
    public init(redirectURL: String,
                bankID: String,
                amount: Decimal,
                currency: PayByBankCurrency,
                description: String? = nil,
                reference: String,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                creditorAccount: PayByBankAccountRequest,
                debtorAccount: PayByBankAccountRequest? = nil,
                paymentOption: PaymentOption? = nil,
                paymentType: PaymentType? = nil) {
        self.redirectURL = redirectURL
        self.bankID = bankID
        self.amount = amount
        self.currency = currency
        self.description = description
        self.reference = reference
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.paymentOption = paymentOption
        self.paymentType = paymentType
    }
}

// MARK: - PaymentOption
public struct PaymentOption: Codable {
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: If not provided, defaults to 'false'.
    public let getRefundInfo: Bool?
    
    /// Set true, if the payment is being created with a possiblity of future payout operation.
    /// - Note: If not provided, defaults to 'false'. If provided as 'true', overwrides `getRefundInfo` to 'true'.
    /// - Warning: Will respond with an error if set 'true' and selected bank does not support refund and is not a direct Faster Payment participant.
    ///  (see: [/banks response model](https://docs.ecospend.com/api/pis/V2/#tag/Banks/paths/~1api~1v2.0~1banks~1{id}/get))
    public let forPayout: Bool?
    
    /// If provided, our system automatically converts the payment into a Scheduled Payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// - Warning: Must be set to a future date/time (it must be the next day or later) in GMT+0.
    public let scheduledFor: Date?
    
    /// Mandatory information for Berlin Group and STET specifications.
    public let psuID: String?
    
    /// The underlying payment rails that the bank transfers the money.
    /// - Note: If not provided, “FasterPayments” is used as the default rails for the UK. Alternatives being “BACS” and “CHAPS”.
    public let paymentRails: String?
    
    enum CodingKeys: String, CodingKey {
        case getRefundInfo = "get_refund_info"
        case forPayout = "for_payout"
        case scheduledFor = "scheduled_for"
        case psuID = "psu_id"
        case paymentRails = "payment_rails"
    }
    
    public init(getRefundInfo: Bool? = nil,
                forPayout: Bool? = nil,
                scheduledFor: Date? = nil,
                psuID: String? = nil,
                paymentRails: String? = nil) {
        self.getRefundInfo = getRefundInfo
        self.forPayout = forPayout
        self.scheduledFor = scheduledFor
        self.psuID = psuID
        self.paymentRails = paymentRails
    }
}

// MARK: - PaymentType
public enum PaymentType: String, Codable {
    case auto = "Auto"
    case domestic = "Domestic"
    case domesticScheduled = "DomesticScheduled"
    case international = "International"
    case internationalScheduled = "InternationalScheduled"
}
