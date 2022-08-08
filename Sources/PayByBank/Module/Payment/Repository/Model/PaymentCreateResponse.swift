//
//  PaymentCreateResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCreateResponse
/// Response model to create Payment.
public struct PaymentCreateResponse: Codable {
    
    /// A system assigned unique identification for the payment.
    /// You may need to use this id to query payments or initiate a refund.
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank.
    /// Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// Initiation date and time of the payment request in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) with fractional seconds.
    public let dateCreated: Date?
    
    /// A unique and one time use only URL of the debtor's banking system.
    /// You will need to redirect PSU to this link in order the payment to proceed.
    public let paymentURL: String?
    
    /// Status of the Payment Initiation.
    /// - Note: Enum: "AwaitingAuthorization"
    public let status: PaymentInitiationStatus?
    
    /// Indicates if the payment is a refund.
    public let isRefund: Bool?
    
    /// The URL submitted with the Request.
    public let redirectURL: String?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    /// Payment amount in decimal format.
    public let amount: Decimal?
    
    /// Currency code  in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Note: Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Note: Enum: "Auto" "Domestic" "DomesticScheduled" "International" "InternationalScheduled"
    public let paymentType: PaymentType?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// Additional fields for a payment that can be mandotary for specific cases.
    public let paymentOption: PaymentOptionResponse?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bankReferenceID = "bank_reference_id"
        case dateCreated = "date_created"
        case paymentURL = "payment_url"
        case status = "status"
        case isRefund = "is_refund"
        case redirectURL = "redirect_url"
        case bankID = "bank_id"
        case amount = "amount"
        case currency = "currency"
        case description = "description"
        case reference = "reference"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case paymentType = "payment_type"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case paymentOption = "payment_option"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - id: A system assigned unique identification for the payment.
    ///     - bankReferenceID: An identification number for the payment that is assigned by the bank.
    ///     - dateCreated: Initiation date and time of the payment request in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) with fractional seconds.
    ///     - paymentURL: A unique and one time use only URL of the debtor's banking system.
    ///     - status:  Instance’s `PaymentInitiationStatus`, which represents status of the Payment Initiation.
    ///     - isRefund: Indicates if the payment is a refund.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the payment journey.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - amount: Payment amount in decimal format.
    ///     - currency:  Instance’s `PayByBankCurrency`, which is currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - paymentType: Instance’s `PaymentType`, which determines which type of payment operation will be executed by the Gateway.
    ///     - creditorAccount:  Instance’s `PayByBankAccountResponse`, which is the account that will receive the payment.
    ///     - debtorAccount:  Instance’s `PayByBankAccountResponse`, which is the account from which the payment will be taken.
    ///     - paymentOption: Instance’s `PaymentOptionResponse`, which is additional fields for a payment that can be mandotary for specific cases.
    public init(id: String?,
                bankReferenceID: String?,
                dateCreated: Date?,
                paymentURL: String?,
                status: PaymentInitiationStatus?,
                isRefund: Bool?,
                redirectURL: String?,
                bankID: String?,
                amount: Decimal?,
                currency: PayByBankCurrency?,
                description: String?,
                reference: String?,
                merchantID: String?,
                merchantUserID: String?,
                paymentType: PaymentType?,
                creditorAccount: PayByBankAccountResponse?,
                debtorAccount: PayByBankAccountResponse?,
                paymentOption: PaymentOptionResponse?) {
        self.id = id
        self.bankReferenceID = bankReferenceID
        self.dateCreated = dateCreated
        self.paymentURL = paymentURL
        self.status = status
        self.isRefund = isRefund
        self.redirectURL = redirectURL
        self.bankID = bankID
        self.amount = amount
        self.currency = currency
        self.description = description
        self.reference = reference
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.paymentType = paymentType
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.paymentOption = paymentOption
    }
}

// MARK: - PaymentInitiationStatus
/// Status of the Payment Initiation.
public enum PaymentInitiationStatus: String, Codable {
    
    /// A PaymentResponse, including bank's payment URL is successfully responded to your call and the PSU is expected to authorise the payment with your redirection.
    case awaitingAuthorization = "AwaitingAuthorization"
}

// MARK: - PaymentOptionResponse
/// Additional fields for a payment that can be mandotary for specific cases.
public struct PaymentOptionResponse: Codable {
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: If not provided, defaults to 'false'.
    public let getRefundInfo: Bool?
    
    /// Set true, if the payment is being created with a possiblity of future payout operation.
    /// - Note: If not provided, defaults to 'false'. If provided as 'true', overwrides `getRefundInfo` to 'true'.
    /// - Warning: Will respond with an error if set 'true' and selected bank does not support refund and is not a direct Faster Payment participant.
    ///  (see: [/banks response model](https://docs.ecospend.com/api/pis/V2/#tag/Banks/paths/~1api~1v2.0~1banks~1{id}/get))
    public let forPayout: Bool?
    
    /// If provided, our system automatically converts the payment into a Scheduled Payment.
    /// It should be in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) with fractional seconds.
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - getRefundInfo: Set true, if you would like to get back the debtor's account information that the payment is made from.
    ///     - forPayout: Set true, if the payment is being created with a possiblity of future payout operation.
    ///     - scheduledFor: If provided, our system automatically converts the payment into a Scheduled Payment.
    ///     - psuID: Mandatory information for Berlin Group and STET specifications.
    ///     - paymentRails: The underlying payment rails that the bank transfers the money.
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
