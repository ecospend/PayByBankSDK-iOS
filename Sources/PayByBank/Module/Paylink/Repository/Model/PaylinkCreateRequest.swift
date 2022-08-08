//
//  PayByBankCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkCreateRequest
/// Request model to create Paylink.
public struct PaylinkCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    /// This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    public let redirectURL: String
    
    /// Payment amount in decimal format.
    public let amount: Decimal
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
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
    public let creditorAccount: PayByBankAccountRequest
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountRequest?
    
    /// Options that are for Paylink.
    public let paylinkOptions: PaylinkOptions?
    
    /// Options that are about notification for Paylink.
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
    /// Options that are about payment for Paylink.
    public let paymentOptions: PaylinkPaymentOptions?
    
    /// Options that are about limit for Paylink.
    public let limitOptions: PaylinkLimitOptions?
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case amount, reference, description
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
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    ///     - amount: Payment amount in decimal format.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - creditorAccount: Instance's `PayByBankAccountRequest`, which is the account that will receive the payment.
    ///     - debtorAccount: Instance's `PayByBankAccountRequest`, which is the account from which the payment will be taken.
    ///     - paylinkOptions: Instance's `PaylinkOptions`, which contains options for Paylink.
    ///     - notificationOptions: Instance's `PayByBankNotificationOptionsRequest`, which contains options about notification.
    ///     - paymentOptions: Instance's `PaylinkPaymentOptions`, which contains options about payment for Paylink.
    ///     - limitOptions: Instance's `PaylinkLimitOptions`, which contains options about limit for Paylink.
    public init(redirectURL: String,
                amount: Decimal,
                reference: String,
                description: String? = nil,
                bankID: String? = nil,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                creditorAccount: PayByBankAccountRequest,
                debtorAccount: PayByBankAccountRequest? = nil,
                paylinkOptions: PaylinkOptions? = nil,
                notificationOptions: PayByBankNotificationOptionsRequest? = nil,
                paymentOptions: PaylinkPaymentOptions? = nil,
                limitOptions: PaylinkLimitOptions? = nil) {
        self.redirectURL = redirectURL
        self.amount = amount
        self.reference = reference
        self.description = description
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

// MARK: - PaylinkLimitOptions
/// Options which are about limit for Paylink.
public struct PaylinkLimitOptions: Codable {
    
    /// Maximum successfull payment count limit.
    public let count: Int?
    
    /// Maximum amount value for collecting payment with the Paylink.
    public let amount: Decimal?
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: Date?
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - count: Maximum successfull payment count limit.
    ///     - amount: Maximum amount value for collecting payment with the Paylink.
    ///     - date: Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(count: Int?,
                amount: Decimal?,
                date: Date?) {
        self.count = count
        self.amount = amount
        self.date = date
    }
}

// MARK: - PaylinkOptions
/// Options which are for Paylink.
public struct PaylinkOptions: Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Note: Defaults to false.
    public let autoRedirect: Bool?
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Optional parameter for allowing user to pay total amount partially.
    /// - Warning: When this value is set, paylink will be expired total amount is comppublic leted.
    /// - Note: Defaults to false.
    public let allowPartialPayments: Bool?
    
    /// Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    public let disableQrCode: Bool?
    
    /// Tip is a voluntary amount.
    public let tip: PaylinkTip?
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case allowPartialPayments = "allow_partial_payments"
        case disableQrCode = "disable_qr_code"
        case tip
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true.
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response.
    ///     - allowPartialPayments: Optional parameter for allowing user to pay total amount partially.
    ///     - disableQrCode: Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    ///     - tip:  Instance's `PaylinkTip`, which is a voluntary amount.
    public init(autoRedirect: Bool?,
                generateQrCode: Bool?,
                allowPartialPayments: Bool?,
                disableQrCode: Bool?,
                tip: PaylinkTip?) {
        self.autoRedirect = autoRedirect
        self.generateQrCode = generateQrCode
        self.allowPartialPayments = allowPartialPayments
        self.disableQrCode = disableQrCode
        self.tip = tip
    }
}

// MARK: - PaylinkTip
/// Tip is a voluntary amount for Paylink.
public struct PaylinkTip: Codable {
    
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

// MARK: - PaylinkTipOption
/// Options which will be listed on the Tip Request Page for Paylink.
public struct PaylinkTipOption: Codable {
    
    /// Tip options type.
    /// - Note: Enum: "Amount" "Percentage" "Manual"
    public let type: PaylinkTipOptionType
    
    /// Tip options value.
    /// - Note: Can be left empy or set to zero(0) if type is manual.
    public let value: Double
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - type: Instance's `PaylinkTipOptionType`, which is type of tip.
    ///     - value: Tip options value. Can be left empy or set to zero(0) if type is manual.
    public init(type: PaylinkTipOptionType,
                value: Double) {
        self.type = type
        self.value = value
    }
}

// MARK: - PaylinkTipOptionType
/// Tip options types for Paylink.
public enum PaylinkTipOptionType: Int, Codable {
    
    /// Amount.
    case amount = 1
    
    /// Percentage.
    case percentage = 2
    
    /// Manual.
    case manual = 3
}

// MARK: - PaylinkPaymentOptions
/// Options that are about payment for Paylink.
public struct PaylinkPaymentOptions: Codable {
    
    /// Payment rails information of the paylink.
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
    ///     - paymentRails: Payment rails information of the paylink.
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
