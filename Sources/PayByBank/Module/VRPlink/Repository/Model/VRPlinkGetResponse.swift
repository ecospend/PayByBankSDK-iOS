//
//  VRPlinkGetResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - VRPlinkGetResponse
/// Response model to get VRPlink.
public struct VRPlinkGetResponse: Codable {
    
    /// Unique id value of Paylink.
    /// - Note: This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// The URL to open bank selection screen
    public let url: String?
    
    /// Unique identification string assigned to the bank by our system.
    /// - If value is set, Paylink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// - If value is not set, Paylink will display the PSU a bank selection screen.
    public let bankID: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// - If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// - If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Enum: "Sweeping" "Vrp"
    public let type: VRPType?
    
    /// It determines which reason of payment operation will be executed by the Gateway.
    /// - Note: Enum: "None" "PartyToParty" "BillPayment" "EcommerceGoods" "EcommerceServices" "Other"
    public let reason: VRPReason?
    
    /// It provides to verify the account that will receive the payment.
    public let verifyCreditorAccount: Bool?
    
    /// It provides to verify the account from which the payment will be taken.
    public let verifyDebtorAccount: Bool?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// Options that are for VRP.
    public let vrpOptions: VRPOptionsResponse?
    
    /// Options that are about limit for VRP.
    public let limitOptions: VRPLimitOptionsResponse?
    
    /// Options that are about notification.
    public let notificationOptions: PayByBankNotificationOptionsResponse?
    
    /// Options that are for VRPlink.
    public let vrplinkOptions: VRPlinkOptionsResponse?
    
    /// Options that are for limit for VRPlink.
    public let vrplinkLimitOptions: VRPlinkLimitOptionsResponse?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case reference = "reference"
        case description = "description"
        case redirectURL = "redirect_url"
        case url = "url"
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case type = "type"
        case reason = "reason"
        case verifyCreditorAccount = "verify_creditor_account"
        case verifyDebtorAccount = "verify_debtor_account"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case vrpOptions = "vrp_options"
        case limitOptions = "limit_options"
        case notificationOptions = "notification_options"
        case vrplinkOptions = "vrplink_options"
        case vrplinkLimitOptions = "vrplink_limit_options"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of Paylink.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - url: The URL to open bank selection screen
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - type:  Instance’s `VRPType`, which determines which type of payment operation will be executed by the Gateway.
    ///     - reason: Instance’s `VRPReason`, which determines which reason of payment operation will be executed by the Gateway.
    ///     - verifyCreditorAccount: It provides to verify the account that will receive the payment.
    ///     - verifyDebtorAccount: It provides to verify the account from which the payment will be taken.
    ///     - creditorAccount:  Instance’s `PayByBankAccountResponse`, which is the account that will receive the payment.
    ///     - debtorAccount:  Instance’s `PayByBankAccountResponse`, which is the account from which the payment will be taken.
    ///     - vrpOptions: Instance’s `VRPOptionsResponse`, which contains options for VRP.
    ///     - limitOptions:  Instance’s `VRPLimitOptionsResponse`, which contains options about limit for VRP.
    ///     - notificationOptions: Instance’s `PayByBankNotificationOptionsResponse`, which contains options about notification.
    ///     - vrplinkOptions: Instance’s `VRPlinkOptionsResponse`, which contains options for VRPlink.
    ///     - vrplinkLimitOptions: Instance’s `VRPlinkLimitOptionsResponse`, which contains options about limit for VRPlink.
    public init(uniqueID: String?,
                reference: String?,
                description: String?,
                redirectURL: String?,
                url: String?,
                bankID: String?,
                merchantID: String?,
                merchantUserID: String?,
                type: VRPType?,
                reason: VRPReason?,
                verifyCreditorAccount: Bool?,
                verifyDebtorAccount: Bool?,
                creditorAccount: PayByBankAccountResponse?,
                debtorAccount: PayByBankAccountResponse?,
                vrpOptions: VRPOptionsResponse?,
                limitOptions: VRPLimitOptionsResponse?,
                notificationOptions: PayByBankNotificationOptionsResponse?,
                vrplinkOptions: VRPlinkOptionsResponse?,
                vrplinkLimitOptions: VRPlinkLimitOptionsResponse?) {
        self.uniqueID = uniqueID
        self.reference = reference
        self.description = description
        self.redirectURL = redirectURL
        self.url = url
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.type = type
        self.reason = reason
        self.verifyCreditorAccount = verifyCreditorAccount
        self.verifyDebtorAccount = verifyDebtorAccount
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.vrpOptions = vrpOptions
        self.limitOptions = limitOptions
        self.notificationOptions = notificationOptions
        self.vrplinkOptions = vrplinkOptions
        self.vrplinkLimitOptions = vrplinkLimitOptions
    }
}

// MARK: - VRPLimitOptionsResponse
/// Options which are about limit for VRP.
public struct VRPLimitOptionsResponse: Codable {
    
    /// Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
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
    
    /// Daily payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let dailyAlignment: VRPAlignment?
    
    /// Weekly payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let weeklyAlignment: VRPAlignment?
    
    /// Fortnightly payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let fortnightlyAlignment: VRPAlignment?
    
    /// Monthly payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let monthlyAlignment: VRPAlignment?
    
    /// HalfYearly payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let halfYearlyAlignment: VRPAlignment?
    
    /// Yearly payment alignment.
    /// - Note: Enum: "Consent" "Calendar"
    public let yearlyAlignment: VRPAlignment?
    
    enum CodingKeys: String, CodingKey {
        case currency = "currency"
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - currency: Instance's `PayByBankCurrency`, which is currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    ///     - singlePaymentAmount: Maximum single payment amount in decimal format.
    ///     - dailyAmount: Daily payment amount limit in decimal format.
    ///     - weeklyAmount: Weekly payment amount limit in decimal format.
    ///     - fortnightlyAmount: Fortnightly payment amount limit in decimal format.
    ///     - monthlyAmount: Monthly payment amount limit in decimal format.
    ///     - halfYearlyAmount: HalfYearly payment amount limit in decimal format.
    ///     - yearlyAmount: Yearly payment amount limit in decimal format.
    ///     - dailyAlignment: Instance's `VRPAlignment`, which is daily payment alignment.
    ///     - weeklyAlignment: Instance's `VRPAlignment`, which is weekly payment alignment.
    ///     - fortnightlyAlignment: Instance's `VRPAlignment`, which is fortnightly payment alignment.
    ///     - monthlyAlignment: Instance's `VRPAlignment`, which is monthly payment alignment.
    ///     - halfYearlyAlignment: Instance's `VRPAlignment`, which is half yearly payment alignment.
    ///     - yearlyAlignment: Instance's `VRPAlignment`, which is yearly payment alignment.
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

// MARK: - VRPOptionsResponse
/// Options which are for VRP.
public struct VRPOptionsResponse: Codable {
    
    /// Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validFrom: Date?
    
    /// Indicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validTo: Date?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: If not provided, defaults to 'true'.
    public let getRefundInfo: Bool?
    
    enum CodingKeys: String, CodingKey {
        case getRefundInfo = "get_refund_info"
        case validFrom = "valid_from"
        case validTo = "valid_to"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - validFrom: Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - validTo: Indicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - getRefundInfo: Set true, if you would like to get back the debtor's account information that the payment is made from.
    public init(validFrom: Date?,
                validTo: Date?,
                getRefundInfo: Bool?) {
        self.validFrom = validFrom
        self.validTo = validTo
        self.getRefundInfo = getRefundInfo
    }
}

// MARK: - VRPlinkLimitOptionsResponse
/// Options which are about limit for VRPlink.
public struct VRPlinkLimitOptionsResponse: Codable {
    
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

// MARK: - VRPlinkOptionsResponse
/// Options which are for VRPlink.
public struct VRPlinkOptionsResponse: Codable {
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Disables QR Code component on Paylinks.
    public let disableQrCode: Bool?
    
    /// After the payment directly returns to the tenant's url if set to true.
    public let autoRedirect: Bool?
    
    /// Client id of the API consumer.
    public let clientID: String?
    
    /// Tenant id of the API consumer.
    public let tenantID: String?
    
    /// If you are set true, no redirect after VRP.
    public let dontRedirect: Bool?
    
    enum CodingKeys: String, CodingKey {
        case generateQrCode = "generate_qr_code"
        case disableQrCode = "disable_qr_code"
        case autoRedirect = "auto_redirect"
        case clientID = "client_id"
        case tenantID = "tenant_id"
        case dontRedirect = "dont_redirect"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response.
    ///     - disableQrCode: Disables QR Code component on Paylinks.
    ///     - autoRedirect: After the payment directly returns to the tenant's url if set to true.
    ///     - clientID: Client id of the API consumer.
    ///     - tenantID: Tenant id of the API consumer.
    ///     - dontRedirect: If you are set true, no redirect after VRP.
    public init(generateQrCode: Bool?,
                disableQrCode: Bool?,
                autoRedirect: Bool?,
                clientID: String?,
                tenantID: String?,
                dontRedirect: Bool?) {
        self.generateQrCode = generateQrCode
        self.disableQrCode = disableQrCode
        self.autoRedirect = autoRedirect
        self.clientID = clientID
        self.tenantID = tenantID
        self.dontRedirect = dontRedirect
    }
}
