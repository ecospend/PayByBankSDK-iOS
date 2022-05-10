//
//  BulkPaymentGetResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - BulkPaymentGetResponse
public struct BulkPaymentGetResponse: Codable {
    
    /// The URL to open bank selection screen
    public let url: String?
    
    /// Id of payment.
    public let paymentID: String?
    
    /// A system assigned unique identification for the Bulk Payment Paylink.
    public let uniqueID: String?
    
    /// Status of the Bulk Payment Paylink.
    /// - Note: Enum: "Initial" "AwaitingAuthorization" "Authorised" "Verified" "Completed" "Canceled" "Failed" "Rejected" "Abandoned"
    public let status: BulkPaymentStatus?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// Bulk payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let fileReference: String?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// Unique identification string assigned to the bank by our system.
    /// If value is set, Paylink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// If value is not set, Paylink will display the PSU a bank selection screen.
    public let bankID: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// The Paylink Options model
    public let paylinkOptions: BulkPaymentPaylinkOptionsResponse?
    
    /// The Notification Options model
    public let notificationOptions: PayByBankNotificationOptionsResponse?
    
    /// The Payment Options model
    public let paymentOptions: BulkPaymentOptionsResponse?
    
    /// The Limit Options model
    public let limitOptions: BulkPaymentLimitOptionsResponse?
    
    /// Payments object for individual payments for the bulk payment.
    public let payments: [BulkPaymentPaylinkEntryResponse]?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case paymentID = "payment_id"
        case uniqueID = "unique_id"
        case status = "status"
        case reference = "reference"
        case fileReference = "file_reference"
        case description = "description"
        case redirectURL = "redirect_url"
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case debtorAccount = "debtor_account"
        case paylinkOptions = "paylink_options"
        case notificationOptions = "notification_options"
        case paymentOptions = "payment_options"
        case limitOptions = "limit_options"
        case payments = "payments"
    }
    
    public init(url: String?,
                paymentID: String?,
                uniqueID: String?,
                status: BulkPaymentStatus?,
                reference: String?,
                fileReference: String?,
                description: String?,
                redirectURL: String?,
                bankID: String?,
                merchantID: String?,
                merchantUserID: String?,
                debtorAccount: PayByBankAccountResponse?,
                paylinkOptions: BulkPaymentPaylinkOptionsResponse?,
                notificationOptions: PayByBankNotificationOptionsResponse?,
                paymentOptions: BulkPaymentOptionsResponse?,
                limitOptions: BulkPaymentLimitOptionsResponse?,
                payments: [BulkPaymentPaylinkEntryResponse]?) {
        self.url = url
        self.paymentID = paymentID
        self.uniqueID = uniqueID
        self.status = status
        self.reference = reference
        self.fileReference = fileReference
        self.description = description
        self.redirectURL = redirectURL
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.debtorAccount = debtorAccount
        self.paylinkOptions = paylinkOptions
        self.notificationOptions = notificationOptions
        self.paymentOptions = paymentOptions
        self.limitOptions = limitOptions
        self.payments = payments
    }
}

public enum BulkPaymentStatus: String, Codable {
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

// MARK: - PaylinkOptions
public struct BulkPaymentPaylinkOptionsResponse: Codable {
    
    /// Client id of the API consumer.
    public let clientID: String?
    
    /// Tenant id of the API consumer.
    public let tenantID: String?
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Note: Defaults to false.
    public let autoRedirect: Bool?
    
    /// If you are set true, no redirect after payment.
    public let dontRedirect: Bool?
    
    /// If bank is pre-set on creation a temporary consent url for payment operation.
    public let temporaryConsentURL: String?
    
    /// Expire date of temporary consent url.
    public let temporaryConsentURLExpireDate: String?
    
    /// Disables QR Code component on paylink.
    public let disableQrCode: Bool?
    
    /// Purpose of the bulk payment.
    public let purpose: String?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case tenantID = "tenant_id"
        case autoRedirect = "auto_redirect"
        case dontRedirect = "dont_redirect"
        case temporaryConsentURL = "temporary_consent_url"
        case temporaryConsentURLExpireDate = "temporary_consent_url_expire_date"
        case disableQrCode = "disable_qr_code"
        case purpose = "purpose"
    }
    
    public init(clientID: String?,
                tenantID: String?,
                autoRedirect: Bool?,
                dontRedirect: Bool?,
                temporaryConsentURL: String?,
                temporaryConsentURLExpireDate: String?,
                disableQrCode: Bool?,
                purpose: String?) {
        self.clientID = clientID
        self.tenantID = tenantID
        self.autoRedirect = autoRedirect
        self.dontRedirect = dontRedirect
        self.temporaryConsentURL = temporaryConsentURL
        self.temporaryConsentURLExpireDate = temporaryConsentURLExpireDate
        self.disableQrCode = disableQrCode
        self.purpose = purpose
    }
}

// MARK: - PaymentOptions
public struct BulkPaymentOptionsResponse: Codable {
    
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

// MARK: - BulkPaymentLimitOptions
public struct BulkPaymentLimitOptionsResponse: Codable {
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: String?
    
    enum CodingKeys: String, CodingKey {
        case date
    }
    
    public init(date: String?) {
        self.date = date
    }
}

// MARK: - BulkPaymentPaylinkEntry
public struct BulkPaymentPaylinkEntryResponse: Codable {
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// Payment amount in decimal format.
    public let amount: Decimal?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
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
    
    public init(creditorAccount: PayByBankAccountResponse?,
                amount: Decimal?,
                reference: String?,
                scheduledFor: String?,
                clientReferenceID: String?) {
        self.creditorAccount = creditorAccount
        self.amount = amount
        self.reference = reference
        self.scheduledFor = scheduledFor
        self.clientReferenceID = clientReferenceID
    }
}
