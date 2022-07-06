//
//  VRPlinkCreateRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//
import Foundation

// MARK: - VRPlinkCreateRequest
public struct VRPlinkCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// Unique identification string assigned to the bank by our system.
    /// - If value is set, Paylink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// - If value is not set, Paylink will display the PSU a bank selection screen.
    public let bankID: String?
    
    /// It determines which reason of payment operation will be executed by the Gateway.
    /// - Enum: "None" "PartyToParty" "BillPayment" "EcommerceGoods" "EcommerceServices" "Other"
    public let reason: VRPReason
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Enum: "Sweeping" "Vrp"
    public let type: VRPType?
    
    /// It provides to verify the account that will receive the payment.
    public let verifyCreditorAccount: Bool?
    
    /// It provides to verify the account from which the payment will be taken.
    public let verifyDebtorAccount: Bool?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// - If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// - If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String
    
    /// Description for the payment. 255 character MAX.
    public let description: String
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountRequest?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountRequest?
    
    /// The VRP Options model
    public let vrpOptions: VRPOptions?
    
    /// The VRP Limit Options Options model
    public let limitOptions: VRPLimitOptions?
    
    /// The Notification Options model
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
    /// The VRPlink Options model
    public let vrplinkOptions: VRPlinkOptions?
    
    /// The VRPlink Limit Options model
    public let vrplinkLimitOptions: VRPlinkLimitOptions?
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case bankID = "bank_id"
        case reason, type
        case verifyCreditorAccount = "verify_creditor_account"
        case verifyDebtorAccount = "verify_debtor_account"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case reference
        case description
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case vrpOptions = "vrp_options"
        case limitOptions = "limit_options"
        case notificationOptions = "notification_options"
        case vrplinkOptions = "vrplink_options"
        case vrplinkLimitOptions = "vrplink_limit_options"
    }
    
    public init(redirectURL: String? = nil,
                bankID: String? = nil,
                reason: VRPReason,
                type: VRPType? = nil,
                verifyCreditorAccount: Bool? = nil,
                verifyDebtorAccount: Bool? = nil,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                reference: String,
                description: String,
                creditorAccount: PayByBankAccountRequest? = nil,
                debtorAccount: PayByBankAccountRequest? = nil,
                vrpOptions: VRPOptions? = nil,
                limitOptions: VRPLimitOptions? = nil,
                notificationOptions: PayByBankNotificationOptionsRequest? = nil,
                vrplinkOptions: VRPlinkOptions? = nil,
                vrplinkLimitOptions: VRPlinkLimitOptions? = nil) {
        self.redirectURL = redirectURL
        self.bankID = bankID
        self.reason = reason
        self.type = type
        self.verifyCreditorAccount = verifyCreditorAccount
        self.verifyDebtorAccount = verifyDebtorAccount
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.reference = reference
        self.description = description
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.vrpOptions = vrpOptions
        self.limitOptions = limitOptions
        self.notificationOptions = notificationOptions
        self.vrplinkOptions = vrplinkOptions
        self.vrplinkLimitOptions = vrplinkLimitOptions
    }
}

// MARK: - VRPReason
public enum VRPReason: String, Codable {
    case none = "None"
    case partyToParty = "PartyToParty"
    case billPayment = "BillPayment"
    case ecommerceGoods = "EcommerceGoods"
    case ecommerceServices = "EcommerceServices"
    case other = "Other"
}

// MARK: - VRPReason
public enum VRPType: String, Codable {
    case sweeping = "Sweeping"
    case vrp = "Vrp"
}

// MARK: - VRPLimitOptions
public struct VRPLimitOptions: Codable {
    
    /// Currency code in ISO 4217 format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency?
    
    /// Maximum single payment amount in decimal format.
    public let singlePaymentAmount: Decimal?
    
    /// Daily payment amount limit in decimal format.
    public let dailyAmount: Decimal?
    
    /// Weekly payment amount limit in decimal format.
    public let weeklyAmount: Decimal?
    
    /// Fortnightly payment amount limit in decimal format.
    public let fortnightlyAmount: Decimal?
    
    /// Monthly payment amount limit in decimal format.
    public let monthlyAmount: Decimal?
    
    /// HalfYearly payment amount limit in decimal format.
    public let halfYearlyAmount: Decimal?
    
    /// Yearly payment amount limit in decimal format.
    public let yearlyAmount: Decimal?
    
    /// Daily payment alignment
    /// - Enum: "Consent" "Calendar"
    public let dailyAlignment: VRPAlignment?
    
    /// Weekly payment alignment
    /// - Enum: "Consent" "Calendar"
    public let weeklyAlignment: VRPAlignment?
    
    /// Fortnightly payment alignment
    /// - Enum: "Consent" "Calendar"
    public let fortnightlyAlignment: VRPAlignment?
    
    /// Monthly payment alignment
    /// - Enum: "Consent" "Calendar"
    public let monthlyAlignment: VRPAlignment?
    
    /// HalfYearly payment alignment
    /// - Enum: "Consent" "Calendar"
    public let halfYearlyAlignment: VRPAlignment?
    
    /// Yearly payment alignment
    /// - Enum: "Consent" "Calendar"
    public let yearlyAlignment: VRPAlignment?
    
    enum CodingKeys: String, CodingKey {
        case currency
        case singlePaymentAmount = "single_payment_amount"
        case dailyAmount = "daily_amount"
        case weeklyAmount = "weekly_amount"
        case fortnightlyAmount = "fortnightly_amount"
        case monthlyAmount = "monthly_amount"
        case halfYearlyAmount = "half_yearly_amount"
        case yearlyAmount = "yearly_amount"
        case dailyAlignment = "daily_alignment"
        case weeklyAlignment = "weekly_alignment"
        case fortnightlyAlignment = "fortnightly_alignment"
        case monthlyAlignment = "monthly_alignment"
        case halfYearlyAlignment = "half_yearly_alignment"
        case yearlyAlignment = "yearly_alignment"
    }
    
    public init(currency: PayByBankCurrency?,
                singlePaymentAmount: Decimal?,
                dailyAmount: Decimal?,
                weeklyAmount: Decimal?,
                fortnightlyAmount: Decimal?,
                monthlyAmount: Decimal?,
                halfYearlyAmount: Decimal?,
                yearlyAmount: Decimal?,
                dailyAlignment: VRPAlignment?,
                weeklyAlignment: VRPAlignment?,
                fortnightlyAlignment: VRPAlignment?,
                monthlyAlignment: VRPAlignment?,
                halfYearlyAlignment: VRPAlignment?,
                yearlyAlignment: VRPAlignment?) {
        self.currency = currency
        self.singlePaymentAmount = singlePaymentAmount
        self.dailyAmount = dailyAmount
        self.weeklyAmount = weeklyAmount
        self.fortnightlyAmount = fortnightlyAmount
        self.monthlyAmount = monthlyAmount
        self.halfYearlyAmount = halfYearlyAmount
        self.yearlyAmount = yearlyAmount
        self.dailyAlignment = dailyAlignment
        self.weeklyAlignment = weeklyAlignment
        self.fortnightlyAlignment = fortnightlyAlignment
        self.monthlyAlignment = monthlyAlignment
        self.halfYearlyAlignment = halfYearlyAlignment
        self.yearlyAlignment = yearlyAlignment
    }
}

// MARK: - VRPAlignment
public enum VRPAlignment: String, Codable {
    case consent = "Consent"
    case calendar = "Calendar"
}

// MARK: - VRPOptions
public struct VRPOptions: Codable {
    
    /// Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validFrom: String?
    
    /// Indicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validTo: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: If not provided, defaults to 'true'.
    public let getRefundInfo: Bool?
    
    enum CodingKeys: String, CodingKey {
        case validFrom = "valid_from"
        case validTo = "valid_to"
        case getRefundInfo = "get_refund_info"
    }
    
    public init(validFrom: String?,
                validTo: String?,
                getRefundInfo: Bool?) {
        self.validFrom = validFrom
        self.validTo = validTo
        self.getRefundInfo = getRefundInfo
    }
}

// MARK: - VRPlinkLimitOptions
public struct VRPlinkLimitOptions: Codable {
    
    /// Expire date for the paylink in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let date: String?
    
    public init(date: String?) {
        self.date = date
    }
}

// MARK: - VRPlinkOptions
public struct VRPlinkOptions: Codable {
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Disables QR Code component on Paylinks
    public let disableQrCode: Bool?
    
    /// After the payment directly returns to the tenant's url if set to true.
    public let autoRedirect: Bool?
    
    /// If you are set true, no redirect after vrp.
    public let dontRedirect: Bool?
    
    enum CodingKeys: String, CodingKey {
        case generateQrCode = "generate_qr_code"
        case disableQrCode = "disable_qr_code"
        case autoRedirect = "auto_redirect"
        case dontRedirect = "dont_redirect"
    }
    
    public init(generateQrCode: Bool?,
                disableQrCode: Bool?,
                autoRedirect: Bool?,
                dontRedirect: Bool?) {
        self.generateQrCode = generateQrCode
        self.disableQrCode = disableQrCode
        self.autoRedirect = autoRedirect
        self.dontRedirect = dontRedirect
    }
}
