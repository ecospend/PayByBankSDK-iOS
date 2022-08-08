//
//  PayByBankGetResponse.swift
//  PayByBankMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkGetResponse
/// Response model to get Paylink.
public struct PaylinkGetResponse: Codable {
    
    /// Unique id value of Paylink.
    public let uniqueID: String?
    
    /// Payment amount in decimal format.
    public let amount: Decimal?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    /// This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    public let redirectURL: String?
    
    /// The URL to open bank selection screen.
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
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// Options that are for Paylink.
    public let paylinkOptions: PaylinkOptionsResponse?
    
    /// Options that are about notification for Paylink.
    public let notificationOptions: PayByBankNotificationOptionsResponse?
    
    /// Options that are about payment for Paylink.
    public let paymentOptions: PaylinkPaymentOptionsResponse?
    
    /// Options that are about limit for Paylink.
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of Paylink.
    ///     - amount: Payment amount in decimal format.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    ///     - url: The URL to open bank selection screen.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - creditorAccount: Instance's `PayByBankAccountResponse`, which is the account that will receive the payment.
    ///     - debtorAccount: Instance's `PayByBankAccountResponse`, which is the account from which the payment will be taken.
    ///     - paylinkOptions: Instance's `PaylinkOptionsResponse`, which contains options for Paylink.
    ///     - notificationOptions: Instance's `PayByBankNotificationOptionsResponse`, which contains options about notification.
    ///     - paymentOptions: Instance's `PaylinkPaymentOptionsResponse`, which contains options about payment for Paylink.
    ///     - limitOptions: Instance's `PaylinkLimitOptionsResponse`, which contains options about limit for Paylink.
    public init(uniqueID: String?,
                amount: Decimal?,
                reference: String?,
                description: String?,
                redirectURL: String?,
                url: String?,
                bankID: String?,
                merchantID: String?,
                merchantUserID: String?,
                creditorAccount: PayByBankAccountResponse?,
                debtorAccount: PayByBankAccountResponse?,
                paylinkOptions: PaylinkOptionsResponse?,
                notificationOptions: PayByBankNotificationOptionsResponse?,
                paymentOptions: PaylinkPaymentOptionsResponse?,
                limitOptions: PaylinkLimitOptionsResponse?) {
        self.uniqueID = uniqueID
        self.amount = amount
        self.reference = reference
        self.description = description
        self.redirectURL = redirectURL
        self.url = url
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.paylinkOptions = paylinkOptions
        self.notificationOptions = notificationOptions
        self.paymentOptions = paymentOptions
        self.limitOptions = limitOptions
    }
}

// MARK: - PaylinkOptionsResponse
/// Options which are for Paylink.
public struct PaylinkOptionsResponse: Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Note: Defaults to false.
    public let autoRedirect: Bool?
    
    /// True if the paylink allows partial payments, false otherwise.
    public let allowPartialPayments: Bool?
    
    /// Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    public let disableQrCode: Bool?
    
    /// Tip is a voluntary amount.
    public let tip: PaylinkTipResponse?
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case allowPartialPayments = "allow_partial_payments"
        case disableQrCode = "disable_qr_code"
        case tip
    }
    
    // Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true.
    ///     - allowPartialPayments: True if the paylink allows partial payments, false otherwise.
    ///     - disableQrCode: Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    ///     - tip: Instance's `PaylinkTipResponse`, which is a voluntary amount.
    public init(autoRedirect: Bool?,
                allowPartialPayments: Bool?,
                disableQrCode: Bool?,
                tip: PaylinkTipResponse?) {
        self.autoRedirect = autoRedirect
        self.allowPartialPayments = allowPartialPayments
        self.disableQrCode = disableQrCode
        self.tip = tip
    }
}

// MARK: - PaylinkTipResponse
/// Tip is a voluntary amount for Paylink.
public struct PaylinkTipResponse: Codable {
    
    /// Denotes whether tip requested from payer.
    public let requestTip: Bool?
    
    /// The Title of the Tip Request Page.
    public let title: String?
    
    /// The informative text on the Tip Request Page.
    public let text: String?
    
    /// Tip can be configured as required. In this case the payer will be forced to select or enter tip amount.
    public let isRequired: Bool?
    
    /// The tip options that will be listed on the Tip Request Page.
    public let options: [PaylinkTipOption]?
    
    enum CodingKeys: String, CodingKey {
        case requestTip = "request_tip"
        case title, text
        case isRequired = "is_required"
        case options
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - requestTip: Denotes whether tip requested from payer.
    ///     - title: The Title of the Tip Request Page.
    ///     - text: The informative text on the Tip Request Page.
    ///     - isRequired: Tip can be configured as required. In this case the payer will be forced to select or enter tip amount.
    ///     - options:  Instance's array of `PaylinkTipOption`, which contains options that will be listed on the Tip Request Page.
    public init(requestTip: Bool?,
                title: String?,
                text: String?,
                isRequired: Bool?,
                options: [PaylinkTipOption]?) {
        self.requestTip = requestTip
        self.title = title
        self.text = text
        self.isRequired = isRequired
        self.options = options
    }
}

// MARK: - PaylinkPaymentOptionsResponse
/// Options that are about payment for Paylink.
public struct PaylinkPaymentOptionsResponse: Codable {
    
    /// Payment rails information of the Paylink.
    public let paymentRails: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: Defaults to true.
    public let getRefundInfo: Bool?
    
    /// Specifies that the payment is for payout operation.
    /// - Note: Default is false.
    public let forPayout: Bool?
    
    enum CodingKeys: String, CodingKey {
        case paymentRails = "payment_rails"
        case getRefundInfo = "get_refund_info"
        case forPayout = "for_payout"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - paymentRails: Payment rails information of the Paylink.
    ///     - getRefundInfo: Set true, if you would like to get back the debtor's account information that the payment is made from.
    ///     - forPayout: Specifies that the payment is for payout operation.
    public init(paymentRails: String?,
                getRefundInfo: Bool?,
                forPayout: Bool?) {
        self.paymentRails = paymentRails
        self.getRefundInfo = getRefundInfo
        self.forPayout = forPayout
    }
}

// MARK: - PaylinkLimitOptionsResponse
/// Options which are about limit for Paylink.
public struct PaylinkLimitOptionsResponse: Codable {
    
    /// Specifies if the limit is exceeded or not.
    public let isLimitExceeded: Bool?
    
    /// Maximum successfull payment count limit.
    public let count: Int?
    
    /// Maximum amount value for collecting payment with the Paylink.
    public let amount: Decimal?
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: Date?
    
    enum CodingKeys: String, CodingKey {
        case isLimitExceeded = "limit_exceeded"
        case count, amount, date
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - isLimitExceeded: Specifies if the limit is exceeded or not.
    ///     - count: Maximum successfull payment count limit.
    ///     - amount: Maximum amount value for collecting payment with the Paylink.
    ///     - date: Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(isLimitExceeded: Bool?,
                count: Int?,
                amount: Decimal?,
                date: Date?) {
        self.isLimitExceeded = isLimitExceeded
        self.count = count
        self.amount = amount
        self.date = date
    }
}
