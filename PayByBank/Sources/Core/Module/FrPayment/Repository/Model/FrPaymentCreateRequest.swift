//
//  FrPaymentCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

// swiftlint:disable line_length

import Foundation

// MARK: - FrPaymentCreateRequest
public struct FrPaymentCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the FrPayment journey.
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
    
    /// Date and time of the first payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// - Warning: This date must be a work day.
    public let firstPaymentDate: String
    
    /// Number of total payments being set with this standing order.
    public let numberOfPayments: Int
    
    /// Period of FrPayment
    /// - Note: Enum: "Weekly" "Monthly" "Yearly"
    public let period: FrPaymentPeriod
    
    /// Standing order type can be Domestic, International or Auto.
    /// - Warning: When 'Auto' is set, Gateway will determine the exact type according to the provided `bankID` and `creditorAccount` details.
    /// - Note: Enum: "Auto" "Domestic" "International"
    public let standingOrderType: FrPaymentStandingOrderType?
    
    /// The FrPayment Options model
    public let frPaymentOptions: FrPaymentOptions?
    
    /// The user has the right to change the FrPayment related additional parameters
    /// - Note: Defaults to false.
    public let allowFrpCustomerChanges: Bool?
    
    /// The Notification Options model
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
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
    ///     - firstPaymentDate: Date and time of the first payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - numberOfPayments: Number of total payments being set with this standing order.
    ///     - period: Period of FrPayment
    ///     - standingOrderType: Standing order type can be Domestic, International or Auto.
    ///     - frPaymentOptions: The FrPayment Options model
    ///     - allowFrpCustomerChanges: The user has the right to change the FrPayment related additional parameters
    ///     - notificationOptions: The Notification Options model
    public init(redirectURL: String,
                amount: Decimal,
                reference: String,
                description: String? = nil,
                bankID: String? = nil,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                creditorAccount: PayByBankAccountRequest,
                debtorAccount: PayByBankAccountRequest? = nil,
                firstPaymentDate: String,
                numberOfPayments: Int,
                period: FrPaymentPeriod,
                standingOrderType: FrPaymentStandingOrderType? = nil,
                frPaymentOptions: FrPaymentOptions? = nil,
                allowFrpCustomerChanges: Bool? = nil,
                notificationOptions: PayByBankNotificationOptionsRequest? = nil) {
        self.redirectURL = redirectURL
        self.amount = amount
        self.reference = reference
        self.description = description
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.firstPaymentDate = firstPaymentDate
        self.numberOfPayments = numberOfPayments
        self.period = period
        self.standingOrderType = standingOrderType
        self.frPaymentOptions = frPaymentOptions
        self.allowFrpCustomerChanges = allowFrpCustomerChanges
        self.notificationOptions = notificationOptions
    }
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case amount, reference
        case description = "description"
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case firstPaymentDate = "first_payment_date"
        case numberOfPayments = "number_of_payments"
        case period
        case standingOrderType = "standing_order_type"
        case frPaymentOptions = "fr_payment_options"
        case allowFrpCustomerChanges = "allow_frp_customer_changes"
        case notificationOptions = "notification_options"
    }
}

// MARK: - FrPaymentPeriod
public enum FrPaymentPeriod: Int, Codable {
    case weekly
    case monthly
    case yearly
}

// MARK: - FrPaymentStandingOrderType
public enum FrPaymentStandingOrderType: String, Codable {
    case auto = "Auto"
    case domestic = "Domestic"
    case international = "International"
}

// MARK: - FrPaymentOptions
public struct FrPaymentOptions: Codable {
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: Defaults to true.
    public let getRefundInfo: Bool?
    
    /// Amount of first payment
    public let firstPaymentAmount: Decimal?
    
    /// Amount of last payment
    public let lastPaymentAmount: Decimal?
    
    /// After the payment directly returns to the tenant's url if set to true.
    /// - Note: Default is false.
    public let autoRedirect: Bool?
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    ///  - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Disables QR Code component on FrPayment
    public let disableQrCode: Bool?
    
    /// Customizes editable options of fields
    public let editableFields: FrPaymentEditableField?
    
    public init(getRefundInfo: Bool?,
                firstPaymentAmount: Decimal?,
                lastPaymentAmount: Decimal?,
                autoRedirect: Bool?,
                generateQrCode: Bool?,
                disableQrCode: Bool?,
                editableFields: FrPaymentEditableField?) {
        self.getRefundInfo = getRefundInfo
        self.firstPaymentAmount = firstPaymentAmount
        self.lastPaymentAmount = lastPaymentAmount
        self.autoRedirect = autoRedirect
        self.generateQrCode = generateQrCode
        self.disableQrCode = disableQrCode
        self.editableFields = editableFields
    }
    
    enum CodingKeys: String, CodingKey {
        case getRefundInfo = "get_refund_info"
        case firstPaymentAmount = "first_payment_amount"
        case lastPaymentAmount = "last_payment_amount"
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case disableQrCode = "disable_qr_code"
        case editableFields = "editable_fields"
    }
}

// MARK: - FrPaymentEditableField
public struct FrPaymentEditableField: Codable {
    
    /// Editable status of first payment date field
    public let firstPaymentDate: Bool?
    
    /// Editable status of first payment amount field
    public let firstPaymentAmount: Bool?
    
    /// Editable status of last payment date field
    public let lastPaymentAmount: Bool?
    
    /// Editable status of  amount field
    public let amount: Bool?
    
    /// Editable status of  period field
    public let period: Bool?
    
    /// Editable status of  number of payments field
    public let numberOfPayments: Bool?
    
    public init(firstPaymentDate: Bool?,
                firstPaymentAmount: Bool?,
                lastPaymentAmount: Bool?,
                amount: Bool?,
                period: Bool?,
                numberOfPayments: Bool?) {
        self.firstPaymentDate = firstPaymentDate
        self.firstPaymentAmount = firstPaymentAmount
        self.lastPaymentAmount = lastPaymentAmount
        self.amount = amount
        self.period = period
        self.numberOfPayments = numberOfPayments
    }
    
    enum CodingKeys: String, CodingKey {
        case firstPaymentDate = "first_payment_date"
        case firstPaymentAmount = "first_payment_amount"
        case lastPaymentAmount = "last_payment_amount"
        case amount, period
        case numberOfPayments = "number_of_payments"
    }
}
