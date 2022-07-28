//
//  PaymentCreateResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCreateResponse
public struct PaymentCreateResponse: Codable {
    
    /// A system assigned unique identification for the payment.
    /// You may need to use this id to query payments or initiate a refund.
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank.
    /// Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// Initiation date and time of the payment request in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format with [time zone designator](https://en.wikipedia.org/wiki/ISO_8601#Time_zone_designators).
    public let dateCreated: Date?
    
    /// A unique and one time use only URL of the debtor's banking system.
    /// You will need to redirect PSU to this link in order the payment to proceed.
    public let paymentURL: String?
    
    /// Status of the Payment Initiation
    /// - Note: Enum: "AwaitingAuthorization"
    public let status: PaymentInitiationStatus?
    
    /// Indicates if the payment is a refund.
    public let isRefund: Bool?
    
    /// The URL submitted with the Request.
    public let redirectURL: String?
    
    /// The `bankID` value submitted with the Request.
    public let bankID: String?
    
    /// The `amount` value submitted with the Request.
    public let amount: Decimal?
    
    /// Currency code  in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Note: Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency?
    
    /// The `description` value submitted with the Request.
    public let description: String?
    
    /// The `reference` value submitted with the Request.
    public let reference: String?
    
    /// The `merchantID` value submitted with the Request.
    public let merchantID: String?
    
    /// The `merchantUserID` value submitted with the Request.
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
public enum PaymentInitiationStatus: String, Codable {
    
    /// A PaymentResponse, including bank's payment URL is successfully responded to your call and the PSU is expected to authorise the payment with your redirection.
    case awaitingAuthorization = "AwaitingAuthorization"
}

// MARK: - PaymentOptionResponse
public struct PaymentOptionResponse: Codable {
    
    /// The `getRefundInfo` value that you provided with the Request (if any).
    public let getRefundInfo: Bool?
    
    /// The `forPayout` value that you provided with the Request (if any).
    public let forPayout: Bool?
    
    /// The `scheduledFor` value that you provided with the Request (if any).
    public let scheduledFor: String?
    
    /// The `psuID` value that you provided with the Request (if any).
    public let psuID: String?
    
    /// The `paymentRails` value that you provided with the Request (if any).
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
                scheduledFor: String? = nil,
                psuID: String? = nil,
                paymentRails: String? = nil) {
        self.getRefundInfo = getRefundInfo
        self.forPayout = forPayout
        self.scheduledFor = scheduledFor
        self.psuID = psuID
        self.paymentRails = paymentRails
    }
}
