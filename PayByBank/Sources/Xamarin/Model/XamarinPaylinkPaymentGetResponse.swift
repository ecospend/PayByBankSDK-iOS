//
//  XamarinPaylinkPaymentGetResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 17.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkPaymentGetResponse
public class XamarinPaylinkPaymentGetResponse: NSObject, Codable {
    
    /// Paylink Id of the payment
    @objc public let uniqueID: String?
    
    /// Client Id of the payment
    @objc public let clientID: String?
    
    /// Client Id of the payment
    @objc public let id: String?
    
    /// An identification number for the payment that is assigned by the bank.
    /// Can have different formats for each bank.
    @objc public let bankReferenceID: String?
    
    /// A unique and one time use only URL from the PSU’s bank. You will need to redirect the PSU to this link for them to authorise a payment.
    @objc public let dateCreated: String?
    
    /// Unique identification string assigned to the bank by our system.
    @objc public let bankID: String?
    
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
    @objc public let status: String?
    
    /// Payment amount in decimal format.
    @objc public let amount: Decimal
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    @objc public let currency: String?
    
    /// The description that you provided with the PaymentRequest (if any).
    @objc public let paymentDescription: String?
    
    /// The reference that you provided with the PaymentRequest.
    @objc public let paymentReference: String?
    
    /// The merchant_id that you provided with the PaymentRequest (if any).
    @objc public let merchantID: String?
    
    /// The merchant_user_id that you provided with the PaymentRequest (if any).
    @objc public let merchantUserID: String?
    
    @objc public let originalPaymentID: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    @objc public let redirectURL: String?
    
    /// Indicates the paylink is auto-redirect
    @objc public let autoRedirect: Bool
    
    /// payment_type determines which type of payment operation will be executed by the Gateway.
    /// - Enum: "Auto" "Domestic" "DomesticScheduled" "International" "InternationalScheduled"
    @objc public let paymentType: String?
    
    /// It is the account that will receive the payment.
    @objc public let creditorAccount: XamarinPaylinkAccountResponse?
    
    /// It is the account from which the payment will be taken.
    @objc public let debtorAccount: XamarinPaylinkAccountResponse?
    
    /// The PaymentOptions model
    @objc public let paymentOptions: XamarinPaylinkPaymentOptionsResponse?
    
    /// The Refund Account model
    @objc public let refundAccount: XamarinPaylinkRefundAccountResponse?
    
    /// Detailed message about the failure reason of the payment (if any).
    @objc public let failureMessage: String?
    
    internal init(uniqueID: String?,
                  clientID: String?,
                  id: String?,
                  bankReferenceID: String?,
                  dateCreated: String?,
                  bankID: String?,
                  status: String?,
                  amount: Decimal,
                  currency: String?,
                  paymentDescription: String?,
                  paymentReference: String?,
                  merchantID: String?,
                  merchantUserID: String?,
                  originalPaymentID: String?,
                  redirectURL: String?,
                  autoRedirect: Bool,
                  paymentType: String?,
                  creditorAccount: XamarinPaylinkAccountResponse?,
                  debtorAccount: XamarinPaylinkAccountResponse?,
                  paymentOptions: XamarinPaylinkPaymentOptionsResponse?,
                  refundAccount: XamarinPaylinkRefundAccountResponse?,
                  failureMessage: String?) {
        self.uniqueID = uniqueID
        self.clientID = clientID
        self.id = id
        self.bankReferenceID = bankReferenceID
        self.dateCreated = dateCreated
        self.bankID = bankID
        self.status = status
        self.amount = amount
        self.currency = currency
        self.paymentDescription = paymentDescription
        self.paymentReference = paymentReference
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.originalPaymentID = originalPaymentID
        self.redirectURL = redirectURL
        self.autoRedirect = autoRedirect
        self.paymentType = paymentType
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.paymentOptions = paymentOptions
        self.refundAccount = refundAccount
        self.failureMessage = failureMessage
    }
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case clientID = "client_id"
        case id
        case bankReferenceID = "bank_reference_id"
        case dateCreated = "date_created"
        case bankID = "bank_id"
        case status
        case redirectURL = "redirect_url"
        case amount, currency
        case paymentDescription = "description"
        case paymentReference = "reference"
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

// MARK: - PaylinkRefundAccountResponse
public class XamarinPaylinkRefundAccountResponse: NSObject, Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    @objc public let type: String?
    
    /// The identification that you provided with the request.
    @objc public let identification: String?
    
    /// The owner_name that you provided with the PaymentRequest.
    @objc public let ownerName: String?
    
    internal init(type: String?,
                  identification: String?,
                  ownerName: String?) {
        self.type = type
        self.identification = identification
        self.ownerName = ownerName
    }
    
    enum CodingKeys: String, CodingKey {
        case type, identification
        case ownerName = "owner_name"
    }
}

// MARK: - PaylinkAccountResponse
public class XamarinPaylinkAccountResponse: NSObject, Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    @objc public let type: String?
    
    /// The identification that you provided with the request.
    @objc public let identification: String?
    
    /// The owner_name that you provided with the PaymentRequest.
    @objc public let name: String?
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    @objc public let currency: String?
    
    /// The bic that you provided with the PaymentRequest (if any).
    @objc public let bic: String?
    
    internal init(type: String?,
                  identification: String?,
                  name: String?,
                  currency: String?,
                  bic: String?) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
        self.bic = bic
    }
}

// MARK: - PaylinkPaymentOptionsResponse
public class XamarinPaylinkPaymentOptionsResponse: NSObject, Codable {
    
    /// Payment rails information of the paylink.
    @objc public let paymentRails: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Defaults to true.
    @objc public let getRefundInfo: Bool
    
    /// Specifies that the payment is for payout operation.
    /// - Default is false.
    @objc public let forPayout: Bool
    
    internal init(paymentRails: String?, getRefundInfo: Bool, forPayout: Bool) {
        self.paymentRails = paymentRails
        self.getRefundInfo = getRefundInfo
        self.forPayout = forPayout
    }
    
    enum CodingKeys: String, CodingKey {
        case paymentRails = "payment_rails"
        case getRefundInfo = "get_refund_info"
        case forPayout = "for_payout"
    }
}

// MARK: - Mapping

extension PaylinkPaymentGetResponse {
    
    internal var xamarinPaylinkPaymentGetResponse: XamarinPaylinkPaymentGetResponse {
        return XamarinPaylinkPaymentGetResponse(uniqueID: self.uniqueID,
                                                clientID: self.clientID,
                                                id: self.id,
                                                bankReferenceID: self.bankReferenceID,
                                                dateCreated: self.dateCreated,
                                                bankID: self.bankID,
                                                status: self.status?.rawValue,
                                                amount: self.amount ?? 0,
                                                currency: self.currency?.rawValue,
                                                paymentDescription: self.description,
                                                paymentReference: self.reference,
                                                merchantID: self.merchantID,
                                                merchantUserID: self.merchantUserID,
                                                originalPaymentID: self.originalPaymentID,
                                                redirectURL: self.redirectURL,
                                                autoRedirect: self.autoRedirect ?? false,
                                                paymentType: self.paymentType?.rawValue,
                                                creditorAccount: self.creditorAccount?.xamarinPaylinkAccountResponse,
                                                debtorAccount: self.debtorAccount?.xamarinPaylinkAccountResponse,
                                                paymentOptions: self.paymentOptions?.xamarinPaylinkPaymentOptionsResponse,
                                                refundAccount: self.refundAccount?.xamarinPaylinkRefundAccountResponse,
                                                failureMessage: self.failureMessage)
    }
}

extension PaylinkAccountResponse {
    
    internal var xamarinPaylinkAccountResponse: XamarinPaylinkAccountResponse {
        return XamarinPaylinkAccountResponse(type: self.type?.rawValue,
                                             identification: self.identification,
                                             name: self.name,
                                             currency: self.currency?.rawValue,
                                             bic: self.bic)
    }
}

extension PaylinkPaymentOptionsResponse {
    
    internal var xamarinPaylinkPaymentOptionsResponse: XamarinPaylinkPaymentOptionsResponse {
        return XamarinPaylinkPaymentOptionsResponse(paymentRails: self.paymentRails,
                                                    getRefundInfo: self.getRefundInfo ?? true,
                                                    forPayout: self.forPayout ?? false)
    }
}

extension PaylinkRefundAccountResponse {
    
    internal var xamarinPaylinkRefundAccountResponse: XamarinPaylinkRefundAccountResponse {
        return XamarinPaylinkRefundAccountResponse(type: self.type?.rawValue,
                                                   identification: self.identification,
                                                   ownerName: self.ownerName)
    }
}
