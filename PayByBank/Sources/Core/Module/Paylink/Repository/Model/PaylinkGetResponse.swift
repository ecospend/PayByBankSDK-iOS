//
//  PayByBankGetResponse.swift
//  PayByBankMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkGetResponse
public struct PaylinkGetResponse: Codable {
    
    /// Unique id value of paylink.
    public let uniqueID: String?
    
    /// Payment amount in decimal format.
    public let amount: Decimal?
    
    // Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    /// This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    public let redirectURL: String?
    
    /// The URL to open bank selection screen
    public let url: String?
    
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
    
    /// The Creditor Account model
    public let creditorAccount: PaylinkAccountResponse?
    
    /// The Debtor Account model
    public let debtorAccount: PaylinkAccountResponse?
    
    /// The Paylink Options model
    public let paylinkOptions: PaylinkOptionsResponse?
    
    /// The Notification Options model
    public let notificationOptions: PaylinkNotificationOptionsResponse?
    
    /// The PaymentOptions model
    public let paymentOptions: PaylinkPaymentOptionsResponse?
    
    /// The LimitOptions model
    public let limitOptions: PaylinkLimitOptionsResponse?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case redirectURL = "redirect_url"
        case url, amount, reference, description
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case paylinkOptions = "paylink_options"
        case notificationOptions = "notification_options"
        case paymentOptions = "payment_options"
        case limitOptions = "limit_options"
    }
}

// MARK: - PaylinkAccountResponse
public struct PaylinkAccountResponse: Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    public let type: PaylinkAccountType?
    
    /// The identification that you provided with the request.
    public let identification: String?
    
    /// The owner_name that you provided with the PaymentRequest.
    public let name: String?
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PaylinkCurrency?
    
    /// The bic that you provided with the PaymentRequest (if any).
    public let bic: String?
}

// MARK: - PaylinkOptionsResponse
public struct PaylinkOptionsResponse: Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Defaults to false.
    public let autoRedirect: Bool?
    
    /// True if the paylink allows partial payments, false otherwise.
    public let allowPartialPayments: Bool?
    
    /// Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    public let disableQrCode: Bool?
    
    /// The Tip object model
    public let tip: PaylinkTipResponse?
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case allowPartialPayments = "allow_partial_payments"
        case disableQrCode = "disable_qr_code"
        case tip
    }
}

// MARK: - PaylinkTipResponse
public struct PaylinkTipResponse: Codable {
    
    /// Denotes whether tip requested from payer.
    public let requestTip: Bool?
    
    /// The Title of the Tip Request Page.
    public let title: String?
    
    /// The informative text on the Tip Request Page.
    public let text: String?
    
    /// Tip can be configured as required.
    /// In this case the payer will be forced to select or enter tip amount.
    public let isRequired: Bool?
    
    /// The tip options that will be listed on the Tip Request Page.
    public let options: [PaylinkTipOption]?
    
    enum CodingKeys: String, CodingKey {
        case requestTip = "request_tip"
        case title, text
        case isRequired = "is_required"
        case options
    }
}

// MARK: - PaylinkNotificationOptionsResponse
public struct PaylinkNotificationOptionsResponse: Codable {
    
    /// True if SendEmailNotification is true and email was sent successfully, otherwise false
    let isEmailSent: Bool?
    
    /// True if SendSmsNotification is true and sms was sent successfully, otherwise false
    let isSmsSent: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isEmailSent = "is_email_sent"
        case isSmsSent = "is_sms_sent"
    }
}

// MARK: - PaylinkPaymentOptionsResponse
public struct PaylinkPaymentOptionsResponse: Codable {
    
    /// Payment rails information of the paylink.
    public let paymentRails: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Defaults to true.
    public let getRefundInfo: Bool?
    
    /// Specifies that the payment is for payout operation.
    /// - Default is false.
    public let forPayout: Bool?
    
    enum CodingKeys: String, CodingKey {
        case paymentRails = "payment_rails"
        case getRefundInfo = "get_refund_info"
        case forPayout = "for_payout"
    }
}

// MARK: - PaylinkLimitOptionsResponse
public struct PaylinkLimitOptionsResponse: Codable {
    
    /// Specifies if the limit is exceeded or not.
    public let isLimitExceeded: Bool?
    
    /// Maximum successfull payment count limit.
    public let count: Int?
    
    /// Maximum amount value for collecting payment with the paylink.
    public let amount: Decimal?
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: String?
    
    enum CodingKeys: String, CodingKey {
        case isLimitExceeded = "limit_exceeded"
        case count, amount, date
    }
}
