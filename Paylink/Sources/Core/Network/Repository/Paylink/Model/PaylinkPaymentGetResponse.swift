//
//  PaylinkPaymentGetResponse.swift
//  PaylinkMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkPaymentGetResponse
public struct PaylinkPaymentGetResponse: Codable {
    
    /// Paylink Id of the payment
    public let uniqueID: String?
    
    /// Client Id of the payment
    public let clientID: String?
    
    /// Client Id of the payment
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank. Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// A unique and one time use only URL from the PSU’s bank. You will need to redirect the PSU to this link for them to authorise a payment.
    public let dateCreated: String?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    
    /// - Enum:
    ///     -  Initial: PaymentRequest is made but a PaymentResponse is not provided yet.
    ///     - AwaitingAuthorization: A PaymentResponse, including bank's payment URL is returned and the PSU is expected to authorise the payment.
    ///     - Authorised: The PSU has authorized the payment from their banking system.
    ///     - Verified: Ecospend and the PSU’s Bank verified the payment authorization. This does not necessarily mean that the money has been received by the creditor account.
    ///     - Completed: Payment is completed, and transfer is made.
    ///     - Canceled: The PSU has cancelled the payment flow.
    ///     - Failed: Payment flow has failed due to an error.
    ///     - Rejected: Bank has rejected the payment.
    ///     - Abandoned: The PSU has deserted the payment journey prior to being redirected back from the bank
    public let status: PaylinkPaymentStatus?
    
    /// Payment amount in decimal format.
    public let amount: Decimal?
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PaylinkCurrency?
    
    /// The description that you provided with the PaymentRequest (if any).
    public let description: String?
    
    /// The reference that you provided with the PaymentRequest.
    public let reference: String?
    
    /// The merchant_id that you provided with the PaymentRequest (if any).
    public let merchantID: String?
    
    /// The merchant_user_id that you provided with the PaymentRequest (if any).
    public let merchantUserID: String?
    
    public let originalPaymentID: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// Indicates the paylink is auto-redirect
    public let autoRedirect: Bool?
    
    /// payment_type determines which type of payment operation will be executed by the Gateway.
    /// - Enum: "Auto" "Domestic" "DomesticScheduled" "International" "InternationalScheduled"
    public let paymentType: PaylinkPaymentType?
    
    /// The Creditor Account model
    public let creditorAccount: PaylinkAccountResponse?
    
    /// The Debtor Account model
    public let debtorAccount: PaylinkAccountResponse?
    
    /// The PaymentOptions model
    public let paymentOptions: PaylinkPaymentOptionsResponse?
    
    /// The Refund Account model
    public let refundAccount: PaylinkRefundAccountResponse?
    
    /// Detailed message about the failure reason of the payment (if any).
    public let failureMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case clientID = "client_id"
        case id
        case bankReferenceID = "bank_reference_id"
        case dateCreated = "date_created"
        case bankID = "bank_id"
        case status
        case redirectURL = "redirect_url"
        case amount, currency, description, reference
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case originalPaymentID = "original_payment_id"
        case autoRedirect = "auto_redirect"
        case paymentType = "payment_type"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case paymentOptions = "payment_options"
        case refundAccount = "refund_account"
        case failureMessage = "failure_message"
    }
}

// MARK: - PaylinkPaymentStatus
public enum PaylinkPaymentStatus: String, Codable {
    case initial = "Initial"
    case awaitingAuthorization = "AwaitingAuthorization"
    case authorised = "Authorised"
    case verified = "Verified"
    case completed = "Completed"
    case canceled = "Canceled"
    case failed = "Failed"
    case rejected = "Rejected"
    case abandoned = "Abandoned"
}

// MARK: - PaylinkPaymentType
public enum PaylinkPaymentType: String, Codable {
    case auto = "Auto"
    case domestic = "Domestic"
    case domesticScheduled = "DomesticScheduled"
    case international = "International"
    case internationalScheduled = "InternationalScheduled"
}

// MARK: - PaylinkRefundAccountResponse
public struct PaylinkRefundAccountResponse: Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    public let type: PaylinkAccountType?
    
    /// The identification that you provided with the request.
    public let identification: String?
    
    /// The owner_name that you provided with the PaymentRequest.
    public let ownerName: String?
    
    enum CodingKeys: String, CodingKey {
        case type, identification
        case ownerName = "owner_name"
    }
}
