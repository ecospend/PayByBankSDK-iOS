//
//  PaymentGetResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentGetResponse
public struct PaymentGetResponse: Codable {
    
    /// A system assigned unique identification for the payment. You may need to use this id to query payments or initiate a refund.
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank.
    /// Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// Initiation date and time of the payment request in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let dateCreated: Date?
    
    /// Status of the payment
    /// - Note: Enum: "Initial" "AwaitingAuthorization" "Authorised" "Verified" "Completed" "Canceled" "Failed" "Rejected" "Abandoned"
    public let status: PaymentStatus?
    
    /// Indicates if the payment is a refund.
    public let isRefund: Bool?
    
    /// If `isRefund`='true', provides the payment_id of the original payment that this refund is created for.
    public let originalPaymentID: String?
    
    /// The URL submitted with the Request.
    public let redirectURL: String?
    
    /// The URL to open bank application or website
    public let url: String?
    
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
    
    /// Additional fields for the payment request.
    public let paymentOption: PaymentOptionResponse?
    
    /// Represents the refund account information structure of that is returned by the bank.
    public let refundAccount: PayByBankAccountResponse?
    
    /// Indicates if the payment transaction is settled on the creditor account. Available with the [optional] Reconciliation Feature.
    public let isReconciled: Bool?
    
    /// Date and time information that is gathered from the creditor account statement by the [optional] Reconciliation Feature in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format with [time zone designator](https://en.wikipedia.org/wiki/ISO_8601#Time_zone_designators)..
    public let reconciliationDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case bankReferenceID = "bank_reference_id"
        case dateCreated = "date_created"
        case status = "status"
        case isRefund = "is_refund"
        case originalPaymentID = "original_payment_id"
        case redirectURL = "redirect_url"
        case url = "payment_url"
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
        case refundAccount = "refund_account"
        case isReconciled = "is_reconciled"
        case reconciliationDate = "reconciliation_date"
    }
    
    public init(id: String?,
                bankReferenceID: String?,
                dateCreated: Date?,
                status: PaymentStatus?,
                isRefund: Bool?,
                originalPaymentID: String?,
                redirectURL: String?,
                url: String?,
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
                paymentOption: PaymentOptionResponse?,
                refundAccount: PayByBankAccountResponse?,
                isReconciled: Bool?,
                reconciliationDate: Date?) {
        self.id = id
        self.bankReferenceID = bankReferenceID
        self.dateCreated = dateCreated
        self.status = status
        self.isRefund = isRefund
        self.originalPaymentID = originalPaymentID
        self.redirectURL = redirectURL
        self.url = url
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
        self.refundAccount = refundAccount
        self.isReconciled = isReconciled
        self.reconciliationDate = reconciliationDate
    }
}

// MARK: - PaymentStatus
public enum PaymentStatus: String, Codable {
    
    /// Your Request POST call to the /payments endpoint is received and registered and the Ecospend Gateway is currently interacting with the bank's system to respond you with a Response.
    /// This is a very brief interim state that will NOT trigger webhooks.
    case initial = "Initial"
    
    /// A Response, including bank's payment URL is successfully responded to your call and the PSU is expected to authorise the payment with your redirection.
    case awaitingAuthorization = "AwaitingAuthorization"
    
    /// The PSU has authorized the payment from their banking system. This is a very brief interim state that will NOT trigger webhooks.
    case authorised = "Authorised"
    
    /// The ASPSP has authorized and accepted the payment for processing. The payment is not completed yet, it has not been sent through the corresponding payment rails. The payment can still be rejected by the ASPSP.
    case verified = "Verified"
    
    /// The Payment is considered as completed when the payer's ASPSP has sent the payment through the corresponding payment rails to be credited to the payee account.
    case completed = "Completed"
    
    /// The PSU has cancelled the payment flow.
    case canceled = "Canceled"
    
    /// Payment flow has failed due to an error.
    case failed = "Failed"
    
    /// Bank has rejected the payment.
    case rejected = "Rejected"
    
    /// The PSU has never initiated the payment journey or deserted the payment journey prior to authorizing the payment on their banking system.
    case abandoned = "Abandoned"
}
