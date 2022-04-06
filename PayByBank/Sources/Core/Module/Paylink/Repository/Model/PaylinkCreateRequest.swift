//
//  PayByBankCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

// swiftlint:disable line_length

import Foundation

// MARK: - PaylinkCreateRequest
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
    public let creditorAccount: PaylinkAccount
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PaylinkAccount?
    
    /// The Paylink Options model
    public let paylinkOptions: PaylinkOptions?
    
    /// The Notification Options model
    public let notificationOptions: PaylinkNotificationOptions?
    
    /// The Payment Options model
    public let paymentOptions: PaylinkPaymentOptions?
    
    /// The Limit Options model
    public let limitOptions: PaylinkLimitOptions?
    
    /// - Parameters:
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the paylink journey. This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    ///     - amount: Payment amount in decimal format.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - bankID: Unique identification string assigned to the bank by our system. If value is set, Paylink will not display any UI and execute an instant redirect to the debtor's banking system. If value is not set, Paylink will display the PSU a bank selection screen.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user. If you are providing this service directly to the end-users, then you can assign that Id to this parameter. If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    ///     - creditorAccount: It is the account that will receive the payment.
    ///     - debtorAccount: It is the account from which the payment will be taken.
    ///     - paylinkOptions: The Paylink Options model
    ///     - notificationOptions: The Notification Options model
    ///     - paymentOptions: The Payment Options model
    ///     - limitOptions: The Limit Options model
    public init(redirectURL: String,
                amount: Decimal,
                reference: String,
                description: String? = nil,
                bankID: String? = nil,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                creditorAccount: PaylinkAccount,
                debtorAccount: PaylinkAccount? = nil,
                paylinkOptions: PaylinkOptions? = nil,
                notificationOptions: PaylinkNotificationOptions? = nil,
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
}

// MARK: - PaylinkAccount
public struct PaylinkAccount: Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    public let type: PaylinkAccountType
    
    /// Account identification. The value of this parameter depends on the value of AccountType.
    /// If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between.
    /// For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    public let identification: String
    
    /// Full legal name of the account owner.
    public let name: String
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PaylinkCurrency
    
    ///  - Parameters:
    ///     - type: Enum: "SortCode" "Iban" "Bban"
    ///     - identification: Account identification. The value of this parameter depends on the value of AccountType. If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between. For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    ///     - name: Full legal name of the account owner.
    ///     - currency: Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format. - Enum: "GBP" "USD" "EUR"
    public init(type: PaylinkAccountType,
                identification: String,
                name: String,
                currency: PaylinkCurrency) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
    }
}

// MARK: - PaylinkCurrency
public enum PaylinkCurrency: String, Codable {
    case gbp = "GBP"
    case usd = "USD"
    case eur = "EUR"
}

// MARK: - PaylinkAccountType
public enum PaylinkAccountType: String, Codable {
    case sortCode = "SortCode"
    case iban = "Iban"
    case bban = "Bban"
}

// MARK: - PaylinkLimitOptions
public struct PaylinkLimitOptions: Codable {
    
    /// Maximum successfull payment count limit.
    public let count: Int?
    
    /// Maximum amount value for collecting payment with the paylink.
    public let amount: Decimal?
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: String?
    
    /// - Parameters:
    ///     - count: Maximum successfull payment count limit.
    ///     - amount: Maximum amount value for collecting payment with the paylink.
    ///     - date: Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(count: Int?,
                amount: Decimal?,
                date: String?) {
        self.count = count
        self.amount = amount
        self.date = date
    }
}

// MARK: - PaylinkNotificationOptions
public struct PaylinkNotificationOptions: Codable {
    
    /// Optional parameter for Gateway to send an email notification to the PSU with the Paylink URL.
    /// - Defaults to false.
    public let sendEmailNotification: Bool?
    
    /// The email address that the email notification will be sent to.
    /// - Warning: This field is **mandatory** if `sendEmailNotification` is true.
    public let email: String?
    
    /// Optional parameter for Gateway to send an SMS notification to the PSU with the Paylink URL.
    /// - Defaults to false.
    public let sendSMSNotification: Bool?
    
    /// The phone number (including the country dial-in code) that the SMS notification will be sent to.
    /// - Warning: This field is **mandatory** if `sendSMSNotification` is true.
    public let phoneNumber: String?
    
    /// - Parameters:
    ///     - sendEmailNotification: Optional parameter for Gateway to send an email notification to the PSU with the Paylink URL. Defaults to false.
    ///     - email: The email address that the email notification will be sent to. This field is **mandatory** if `sendEmailNotification` is true.
    ///     - sendSMSNotification: Optional parameter for Gateway to send an SMS notification to the PSU with the Paylink URL. Defaults to false.
    ///     - phoneNumber: The phone number (including the country dial-in code) that the SMS notification will be sent to. This field is **mandatory** if `sendSMSNotification` is true.
    public init(sendEmailNotification: Bool?,
                email: String?,
                sendSMSNotification: Bool?,
                phoneNumber: String?) {
        self.sendEmailNotification = sendEmailNotification
        self.email = email
        self.sendSMSNotification = sendSMSNotification
        self.phoneNumber = phoneNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case sendEmailNotification = "send_email_notification"
        case email
        case sendSMSNotification = "send_sms_notification"
        case phoneNumber = "phone_number"
    }
}

// MARK: - PaylinkOptions
public struct PaylinkOptions: Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Defaults to false.
    public let autoRedirect: Bool?
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Defaults to false.
    public let generateQrCode: Bool?
    
    /// Optional parameter for allowing user to pay total amount partially.
    /// - Warning: When this value is set, paylink will be expired total amount is comppublic leted.
    /// - Defaults to false.
    public let allowPartialPayments: Bool?
    
    /// Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    public let disableQrCode: Bool?
    
    /// The Tip object model
    public let tip: PaylinkTip?
    
    /// - Parameters:
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true. Defaults to false.
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response. Defaults to false.
    ///     - allowPartialPayments: Optional parameter for allowing user to pay total amount partially. When this value is set, paylink will be expired total amount is comppublic leted. Defaults to false.
    ///     - disableQrCode: Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    ///     - tip: The Tip object model
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
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case allowPartialPayments = "allow_partial_payments"
        case disableQrCode = "disable_qr_code"
        case tip
    }
}

// MARK: - PaylinkTip
public struct PaylinkTip: Codable {
    
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
    
    /// - Parameters:
    ///     - requestTip: Denotes whether tip requested from payer.
    ///     - title: The Title of the Tip Request Page.
    ///     - text: The informative text on the Tip Request Page.
    ///     - isRequired: Tip can be configured as required. In this case the payer will be forced to select or enter tip amount.
    ///     - options: The tip options that will be listed on the Tip Request Page.
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
    
    enum CodingKeys: String, CodingKey {
        case requestTip = "request_tip"
        case title, text
        case isRequired = "is_required"
        case options
    }
}

// MARK: - PaylinkTipOption
public struct PaylinkTipOption: Codable {
    
    /// Tip options type.
    /// Enum: "Amount" "Percentage" "Manual"
    public let type: PaylinkTipOptionType
    
    /// Tip options value.
    /// - Can be left empy or set to zero(0) if type is manual.
    public let value: Double
    
    /// - Parameters:
    ///     - type: Tip options type. Enum: "Amount" "Percentage" "Manual"
    ///     - value: Tip options value. Can be left empy or set to zero(0) if type is manual.
    public init(type: PaylinkTipOptionType,
                value: Double) {
        self.type = type
        self.value = value
    }
}

// MARK: - PaylinkTipOptionType
public enum PaylinkTipOptionType: Int, Codable {
    case amount = 1
    case percentage = 2
    case manual = 3
}

// MARK: - PaylinkPaymentOptions
public struct PaylinkPaymentOptions: Codable {
    
    /// Payment rails information of the paylink.
    public let paymentRails: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Defaults to true.
    public let getRefundInfo: Bool?
    
    /// Specifies that the payment is for payout operation.
    /// - Default is false.
    public let forPayout: Bool?
    
    /// - Parameters:
    ///     - paymentRails: Payment rails information of the paylink.
    ///     - getRefundInfo: Set true, if you would like to get back the debtor's account information that the payment is made from. Defaults to true.
    ///     - forPayout: Specifies that the payment is for payout operation. Default is false.
    public init(paymentRails: String?,
                getRefundInfo: Bool?,
                forPayout: Bool?) {
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
