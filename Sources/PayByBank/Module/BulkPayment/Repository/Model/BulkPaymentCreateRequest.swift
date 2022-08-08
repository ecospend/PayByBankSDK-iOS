//
//  BulkPaymentCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - BulkPaymentCreateRequest
/// Request model to create Bulk Payment.
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
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// Options that are about payment.
    public let paymentOptions: BulkPaymentOptions?
    
    /// Options that are about paylink.
    public let options: BulkPaymentPaylinkOptions?
    
    /// Options that are about notification.
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
    /// Options that are about limit.
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - debtorAccount: Instance's `PayByBankAccountRequest`, which is the account from which the payment will be taken.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - fileReference: Bulk payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - paymentOptions: Instance's `BulkPaymentOptions`, which contains options about payment.
    ///     - options: Instance's `BulkPaymentPaylinkOptions`, which contains options about paylink.
    ///     - notificationOptions: Instance's `PayByBankNotificationOptionsRequest`, which contains options about notification.
    ///     - limitOptions: Instance's `BulkPaymentLimitOptions`, which contains options about limit.
    ///     - payments: Instance's array of `BulkPaymentPaylinkEntry`, which is for individual payments for the bulk payment.
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
/// Options which are about limit for Bulk Payment.
public struct BulkPaymentLimitOptions: Codable {
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case date
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - date: Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(date: Date?) {
        self.date = date
    }
}

// MARK: - BulkPaymentPaylinkOptions
/// Options which are about paylink for Bulk Payment.
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true.
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response.
    ///     - disableQrCode: Disables QR Code component on Paylinks.
    ///     - purpose: Purpose of the bulk payment.
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
/// Options which are about payment for Bulk Payment.
public struct BulkPaymentOptions: Codable {
    
    /// Defines the schedule date for the payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let scheduledFor: Date?
    
    /// Gets or sets the bulk payment rails.
    public let paymentRails: String?
    
    enum CodingKeys: String, CodingKey {
        case scheduledFor = "scheduled_for"
        case paymentRails = "payment_rails"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - scheduledFor: Defines the schedule date for the payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - paymentRails: Gets or sets the bulk payment rails.
    public init(scheduledFor: Date?, paymentRails: String?) {
        self.scheduledFor = scheduledFor
        self.paymentRails = paymentRails
    }
}

// MARK: - BulkPaymentPaylinkEntry
/// Payment model for the Bulk Payment
public struct BulkPaymentPaylinkEntry: Codable {
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountRequest
    
    /// Payment amount in decimal format.
    public let amount: Decimal
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// Defines the schedule date for the payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// - Warning: Must be set to a date/time in GMT+0.
    public let scheduledFor: Date?
    
    /// Free text field for any client reference usage.
    public let clientReferenceID: String?
    
    enum CodingKeys: String, CodingKey {
        case creditorAccount = "creditor_account"
        case amount = "amount"
        case reference = "reference"
        case scheduledFor = "scheduled_for"
        case clientReferenceID = "client_reference_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - creditorAccount: Instance's `PayByBankAccountRequest`, which is the account that will receive the payment..
    ///     - amount: Payment amount in decimal format.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - scheduledFor: Defines the schedule date for the payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - clientReferenceID: Free text field for any client reference usage.
    public init(creditorAccount: PayByBankAccountRequest,
                amount: Decimal,
                reference: String,
                scheduledFor: Date?,
                clientReferenceID: String?) {
        self.creditorAccount = creditorAccount
        self.amount = amount
        self.reference = reference
        self.scheduledFor = scheduledFor
        self.clientReferenceID = clientReferenceID
    }
}
