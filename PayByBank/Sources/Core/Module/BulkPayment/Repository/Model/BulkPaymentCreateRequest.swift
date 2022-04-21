//
//  BulkPaymentCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - BulkPaymentCreateRequest
public struct BulkPaymentCreateRequest: Codable {
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountRequest?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// Bulk payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let fileReference: String
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// The Payment Options model
    public let paymentOptions: BulkPaymentOptions?
    
    /// The Paylink Options model
    public let options: BulkPaymentPaylinkOptions?
    
    /// The Notification Options model
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
    /// The Limit Options model
    public let limitOptions: BulkPaymentLimitOptions?
    
    /// Payments object for individual payments for the bulk payment.
    public let payments: [BulkPaymentPaylinkEntry]
    
    enum CodingKeys: String, CodingKey {
        case bankID = "bank_id"
        case debtorAccount = "debtor_account"
        case description = "description"
        case fileReference = "file_reference"
        case reference = "reference"
        case redirectURL = "redirect_url"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case paymentOptions = "payment_options"
        case options = "options"
        case notificationOptions = "notification_options"
        case limitOptions = "limit_options"
        case payments = "payments"
    }
    
    public init(bankID: String? = nil,
                debtorAccount: PayByBankAccountRequest? = nil,
                description: String? = nil,
                fileReference: String,
                reference: String? = nil,
                redirectURL: String,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                paymentOptions: BulkPaymentOptions? = nil,
                options: BulkPaymentPaylinkOptions? = nil,
                notificationOptions: PayByBankNotificationOptionsRequest? = nil,
                limitOptions: BulkPaymentLimitOptions? = nil,
                payments: [BulkPaymentPaylinkEntry]) {
        self.bankID = bankID
        self.debtorAccount = debtorAccount
        self.description = description
        self.fileReference = fileReference
        self.reference = reference
        self.redirectURL = redirectURL
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.paymentOptions = paymentOptions
        self.options = options
        self.notificationOptions = notificationOptions
        self.limitOptions = limitOptions
        self.payments = payments
    }
}

// MARK: - BulkPaymentLimitOptions
public struct BulkPaymentLimitOptions: Codable {
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: String?
    
    enum CodingKeys: String, CodingKey {
        case date
    }
    
    public init(date: String?) {
        self.date = date
    }
}

// MARK: - BulkPaymentPaylinkOptions
public struct BulkPaymentPaylinkOptions: Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Note: Defaults to false.
    public let autoRedirect: Bool?
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Disables QR Code component on Paylinks
    public let disableQrCode: Bool?
    
    /// Purpose of the bulk payment.
    public let purpose: String?
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case disableQrCode = "disable_qr_code"
        case purpose = "purpose"
    }
    
    public init(autoRedirect: Bool?,
                generateQrCode: Bool?,
                disableQrCode: Bool?,
                purpose: String?) {
        self.autoRedirect = autoRedirect
        self.generateQrCode = generateQrCode
        self.disableQrCode = disableQrCode
        self.purpose = purpose
    }
}

// MARK: - BulkPaymentOptions
public struct BulkPaymentOptions: Codable {
    
    /// Defines the schedule date  for the payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let scheduledFor: String?
    
    /// Gets or sets the bulk payment rails.
    public let paymentRails: String?
    
    enum CodingKeys: String, CodingKey {
        case scheduledFor = "scheduled_for"
        case paymentRails = "payment_rails"
    }
    
    public init(scheduledFor: String?, paymentRails: String?) {
        self.scheduledFor = scheduledFor
        self.paymentRails = paymentRails
    }
}

// MARK: - BulkPaymentPaylinkEntry
public struct BulkPaymentPaylinkEntry: Codable {
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountRequest
    
    /// Payment amount in decimal format.
    public let amount: Decimal
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// Must be set to a date/time in GMT+0 in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let scheduledFor: String?
    
    /// Free text field for any client reference usage.
    public let clientReferenceID: String?
    
    enum CodingKeys: String, CodingKey {
        case creditorAccount = "creditor_account"
        case amount = "amount"
        case reference = "reference"
        case scheduledFor = "scheduled_for"
        case clientReferenceID = "client_reference_id"
    }
    
    public init(creditorAccount: PayByBankAccountRequest,
                amount: Decimal,
                reference: String,
                scheduledFor: String?,
                clientReferenceID: String?) {
        self.creditorAccount = creditorAccount
        self.amount = amount
        self.reference = reference
        self.scheduledFor = scheduledFor
        self.clientReferenceID = clientReferenceID
    }
}
