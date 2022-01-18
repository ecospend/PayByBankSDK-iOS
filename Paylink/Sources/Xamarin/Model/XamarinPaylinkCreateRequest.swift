//
//  XamarinPaylinkCreateRequest.swift
//  Paylink
//
//  Created by Yunus TÜR on 17.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkCreateRequest
public class XamarinPaylinkCreateRequest: NSObject, Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    /// This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    @objc public let redirectURL: String
    
    /// Payment amount in decimal format.
    @objc public let amount: Decimal
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    @objc public let paymentReference: String
    
    /// Description for the payment. 255 character MAX.
    @objc public let paymentDescription: String?
    
    /// Unique identification string assigned to the bank by our system.
    /// If value is set, Paylink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// If value is not set, Paylink will display the PSU a bank selection screen.
    @objc public let bankID: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    @objc public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    @objc public let merchantUserID: String?
    
    /// It is the account that will receive the payment.
    @objc public let creditorAccount: XamarinPaylinkAccount
    
    /// It is the account from which the payment will be taken.
    @objc public let debtorAccount: XamarinPaylinkAccount?
    
    /// The Paylink Options model
    @objc public let paylinkOptions: XamarinPaylinkOptions?
    
    /// The Notification Options model
    @objc public let notificationOptions: XamarinPaylinkNotificationOptions?
    
    /// The Payment Options model
    @objc public let paymentOptions: XamarinPaylinkPaymentOptions?
    
    /// The Limit Options model
    @objc public let limitOptions: XamarinPaylinkLimitOptions?
    
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
    @objc public init(redirectURL: String,
                      amount: Decimal,
                      paymentReference: String,
                      paymentDescription: String? = nil,
                      bankID: String? = nil,
                      merchantID: String? = nil,
                      merchantUserID: String? = nil,
                      creditorAccount: XamarinPaylinkAccount,
                      debtorAccount: XamarinPaylinkAccount? = nil,
                      paylinkOptions: XamarinPaylinkOptions? = nil,
                      notificationOptions: XamarinPaylinkNotificationOptions? = nil,
                      paymentOptions: XamarinPaylinkPaymentOptions? = nil,
                      limitOptions: XamarinPaylinkLimitOptions? = nil) {
        self.redirectURL = redirectURL
        self.amount = amount
        self.paymentReference = paymentReference
        self.paymentDescription = paymentDescription
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
        case amount
        case paymentReference = "reference"
        case paymentDescription = "description"
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
    
    internal var paylinkCreateRequest: PaylinkCreateRequest {
        return PaylinkCreateRequest(redirectURL: self.redirectURL,
                                    amount: self.amount,
                                    reference: self.paymentReference,
                                    description: self.paymentDescription,
                                    bankID: self.bankID,
                                    merchantID: self.merchantID,
                                    merchantUserID: self.merchantUserID,
                                    creditorAccount: self.creditorAccount.paylinkAccount,
                                    debtorAccount: self.debtorAccount?.paylinkAccount,
                                    paylinkOptions: self.paylinkOptions?.paylinkOptions,
                                    notificationOptions: self.notificationOptions?.paylinkNotificationOptions,
                                    paymentOptions: self.paymentOptions?.paylinkPaymentOptions,
                                    limitOptions: self.limitOptions?.paylinkLimitOptions)
    }
}

// MARK: - PaylinkAccount
public class XamarinPaylinkAccount: NSObject, Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    @objc public let type: String
    
    /// Account identification. The value of this parameter depends on the value of AccountType.
    /// If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between.
    /// For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    @objc public let identification: String
    
    /// Full legal name of the account owner.
    @objc public let name: String
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    @objc public let currency: String
    
    ///  - Parameters:
    ///     - type: Enum: "SortCode" "Iban" "Bban"
    ///     - identification: Account identification. The value of this parameter depends on the value of AccountType. If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between. For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    ///     - name: Full legal name of the account owner.
    ///     - currency: Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format. - Enum: "GBP" "USD" "EUR"
    @objc public init(type: String,
                      identification: String,
                      name: String,
                      currency: String) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
    }
    
    internal var paylinkAccount: PaylinkAccount {
        let type = PaylinkAccountType(rawValue: self.type) ?? .sortCode
        let currency = PaylinkCurrency(rawValue: self.currency) ?? .gbp
        
        return PaylinkAccount(type: type,
                              identification: self.identification,
                              name: self.name,
                              currency: currency)
    }
}

// MARK: - PaylinkLimitOptions
public class XamarinPaylinkLimitOptions: NSObject, Codable {
    
    /// Maximum successfull payment count limit.
    @objc public let count: Int
    
    /// Maximum amount value for collecting payment with the paylink.
    @objc public let amount: Decimal
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    @objc public let date: String?
    
    /// - Parameters:
    ///     - count: Maximum successfull payment count limit.
    ///     - amount: Maximum amount value for collecting payment with the paylink.
    ///     - date: Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    @objc public init(count: Int,
                      amount: Decimal,
                      date: String?) {
        self.count = count
        self.amount = amount
        self.date = date
    }
    
    internal var paylinkLimitOptions: PaylinkLimitOptions {
        return PaylinkLimitOptions(count: self.count, amount: self.amount, date: self.date)
    }
}

// MARK: - PaylinkNotificationOptions
public class XamarinPaylinkNotificationOptions: NSObject, Codable {
    
    /// Optional parameter for Gateway to send an email notification to the PSU with the Paylink URL.
    /// - Defaults to false.
    @objc public let sendEmailNotification: Bool
    
    /// The email address that the email notification will be sent to.
    /// - Warning: This field is **mandatory** if `sendEmailNotification` is true.
    @objc public let email: String?
    
    /// Optional parameter for Gateway to send an SMS notification to the PSU with the Paylink URL.
    /// - Defaults to false.
    @objc public let sendSMSNotification: Bool
    
    /// The phone number (including the country dial-in code) that the SMS notification will be sent to.
    /// - Warning: This field is **mandatory** if `sendSMSNotification` is true.
    @objc public let phoneNumber: String?
    
    /// - Parameters:
    ///     - sendEmailNotification: Optional parameter for Gateway to send an email notification to the PSU with the Paylink URL. Defaults to false.
    ///     - email: The email address that the email notification will be sent to. This field is **mandatory** if `sendEmailNotification` is true.
    ///     - sendSMSNotification: Optional parameter for Gateway to send an SMS notification to the PSU with the Paylink URL. Defaults to false.
    ///     - phoneNumber: The phone number (including the country dial-in code) that the SMS notification will be sent to. This field is **mandatory** if `sendSMSNotification` is true.
    @objc public init(sendEmailNotification: Bool,
                      email: String?,
                      sendSMSNotification: Bool,
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
    
    internal var paylinkNotificationOptions: PaylinkNotificationOptions {
        return PaylinkNotificationOptions(sendEmailNotification: self.sendEmailNotification,
                                          email: self.email,
                                          sendSMSNotification: self.sendSMSNotification,
                                          phoneNumber: self.phoneNumber)
    }
}

// MARK: - PaylinkOptions
public class XamarinPaylinkOptions: NSObject, Codable {
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Defaults to false.
    @objc public let autoRedirect: Bool
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Defaults to false.
    @objc public let generateQrCode: Bool
    
    /// Optional parameter for allowing user to pay total amount partially.
    /// - Warning: When this value is set, paylink will be expired total amount is comppublic leted.
    /// - Defaults to false.
    @objc public let allowPartialPayments: Bool
    
    /// Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    @objc public let disableQrCode: Bool
    
    /// The Tip object model
    @objc public let tip: XamarinPaylinkTip?
    
    /// - Parameters:
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true. Defaults to false.
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response. Defaults to false.
    ///     - allowPartialPayments: Optional parameter for allowing user to pay total amount partially. When this value is set, paylink will be expired total amount is comppublic leted. Defaults to false.
    ///     - disableQrCode: Optional parameter for displaying a QR Code on the paylink screens, that enables users to transfer their journey from desktop to mobile easily. This feature is only visible on desktop view.
    ///     - tip: The Tip object model
    @objc public init(autoRedirect: Bool,
                      generateQrCode: Bool,
                      allowPartialPayments: Bool,
                      disableQrCode: Bool,
                      tip: XamarinPaylinkTip?) {
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
    
    internal var paylinkOptions: PaylinkOptions {
        return PaylinkOptions(autoRedirect: self.autoRedirect,
                              generateQrCode: self.generateQrCode,
                              allowPartialPayments: self.allowPartialPayments,
                              disableQrCode: self.disableQrCode,
                              tip: self.tip?.paylinkTip)
    }
}

// MARK: - PaylinkTip
public class XamarinPaylinkTip: NSObject, Codable {
    
    /// Denotes whether tip requested from payer.
    @objc public let requestTip: Bool
    
    /// The Title of the Tip Request Page.
    @objc public let title: String?
    
    /// The informative text on the Tip Request Page.
    @objc public let text: String?
    
    /// Tip can be configured as required.
    /// In this case the payer will be forced to select or enter tip amount.
    @objc public let isRequired: Bool
    
    /// The tip options that will be listed on the Tip Request Page.
    @objc public let options: [XamarinPaylinkTipOption]?
    
    /// - Parameters:
    ///     - requestTip: Denotes whether tip requested from payer.
    ///     - title: The Title of the Tip Request Page.
    ///     - text: The informative text on the Tip Request Page.
    ///     - isRequired: Tip can be configured as required. In this case the payer will be forced to select or enter tip amount.
    ///     - options: The tip options that will be listed on the Tip Request Page.
    @objc public init(requestTip: Bool,
                      title: String?,
                      text: String?,
                      isRequired: Bool,
                      options: [XamarinPaylinkTipOption]?) {
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
    
    internal var paylinkTip: PaylinkTip {
        return PaylinkTip(requestTip: self.requestTip,
                          title: self.title,
                          text: self.text,
                          isRequired: self.isRequired,
                          options: self.options?.map { $0.paylinkTipOption })
    }
}

// MARK: - PaylinkTipOption
public class XamarinPaylinkTipOption: NSObject, Codable {
    
    /// Tip options type.
    /// Enum: "Amount"=1 "Percentage"=2 "Manual"=3
    @objc public let type: Int
    
    /// Tip options value.
    /// - Can be left empy or set to zero(0) if type is manual.
    @objc public let value: Double
    
    /// - Parameters:
    ///     - type: Tip options type. Enum: "Amount"=1 "Percentage"=2 "Manual"=3
    ///     - value: Tip options value. Can be left empy or set to zero(0) if type is manual.
    @objc public init(type: Int,
                      value: Double) {
        self.type = type
        self.value = value
    }
    
    internal var paylinkTipOption: PaylinkTipOption {
        let type = PaylinkTipOptionType(rawValue: self.type) ?? .amount
        return PaylinkTipOption(type: type, value: self.value)
    }
}

// MARK: - PaylinkPaymentOptions
public class XamarinPaylinkPaymentOptions: NSObject, Codable {
    
    /// Payment rails information of the paylink.
    @objc public let paymentRails: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Defaults to true.
    @objc public let getRefundInfo: Bool
    
    /// Specifies that the payment is for payout operation.
    /// - Default is false.
    @objc public let forPayout: Bool
    
    /// - Parameters:
    ///     - paymentRails: Payment rails information of the paylink.
    ///     - getRefundInfo: Set true, if you would like to get back the debtor's account information that the payment is made from. Defaults to true.
    ///     - forPayout: Specifies that the payment is for payout operation. Default is false.
    @objc public init(paymentRails: String,
                      getRefundInfo: Bool,
                      forPayout: Bool) {
        self.paymentRails = paymentRails
        self.getRefundInfo = getRefundInfo
        self.forPayout = forPayout
    }
    
    enum CodingKeys: String, CodingKey {
        case paymentRails = "payment_rails"
        case getRefundInfo = "get_refund_info"
        case forPayout = "for_payout"
    }
    
    internal var paylinkPaymentOptions: PaylinkPaymentOptions {
        return PaylinkPaymentOptions(paymentRails: self.paymentRails,
                                     getRefundInfo: self.getRefundInfo,
                                     forPayout: self.forPayout)
    }
}
