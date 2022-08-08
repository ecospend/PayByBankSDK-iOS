//
//  DatalinkCreateRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkCreateRequest
/// Request model to create Datalink.
public struct DatalinkCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of account access process.
    public let redirectURL: String
    
    /// Unique identification string assigned to the bank by our system.
    /// If value is set, Datalink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// If value is not set, Datalink will display the PSU a bank selection screen.
    public let bankID: String?
    
    /// If you are providing our Data service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// The date indicating when consent will end.
    public let consentEndDate: Date?
    
    /// The date indicating when consent will expire.
    public let expiryDate: Date?
    
    /// The permissions which will be asked to the users while connecting their account.
    /// Determines which data will be fetched
    /// If it is not set, system will automatically set all the permissions
    public let permissions: [ConsentPermission]?
    
    /// Options that are about Datalink.
    public let datalinkOptions: DatalinkOptions?
    
    /// Options that are about notification.
    public let notificationOptions: PayByBankNotificationOptionsRequest?
    
    /// Options that are about financial reporting.
    public let financialReport: FinancialReport?
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case consentEndDate = "consent_end_date"
        case expiryDate = "expiry_date"
        case permissions
        case datalinkOptions = "datalink_options"
        case notificationOptions = "notification_options"
        case financialReport = "financial_report"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of account access process.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - merchantID: If you are providing our Data service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - consentEndDate: The URL to open bank selection screen.
    ///     - expiryDate: The date indicating when consent will expire.
    ///     - permissions: Instance's array of `ConsentPermission`, which will be asked to the users while connecting their account..
    ///     - datalinkOptions: Instance's `DatalinkOptions`, which contains options about Datalink.
    ///     - notificationOptions: Instance's `PayByBankNotificationOptionsRequest`, which contains options about notification.
    ///     - financialReport: Instance's `FinancialReport`, which contains options about financial reporting.
    public init(redirectURL: String,
                bankID: String? = nil,
                merchantID: String? = nil,
                merchantUserID: String? = nil,
                consentEndDate: Date,
                expiryDate: Date? = nil,
                permissions: [ConsentPermission]? = nil,
                datalinkOptions: DatalinkOptions? = nil,
                notificationOptions: PayByBankNotificationOptionsRequest? = nil,
                financialReport: FinancialReport? = nil) {
        self.redirectURL = redirectURL
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.consentEndDate = consentEndDate
        self.expiryDate = expiryDate
        self.permissions = permissions
        self.datalinkOptions = datalinkOptions
        self.notificationOptions = notificationOptions
        self.financialReport = financialReport
    }
}

// MARK: - DatalinkOptions
/// Options that are about Datalink.
public struct DatalinkOptions: Codable {
    
    /// Determines if the PSU will see a completed page by Ecospend.
    /// If it is set true, then PSU will be redirected directly to Tenant's redirect page If it is set false, then PSU will see the consent completed page wihch provided by the Ecospend
    public let autoRedirect: Bool?
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// - Note: Defaults to false.
    public let generateQrCode: Bool?
    
    /// Optional parameter for allowing user to create consent multiply.
    /// - When this value is set, datalink will be ask for connect an another account at the end of journey.
    /// - Note: Defaults to false.
    public let allowMultipleConsent: Bool?
    
    /// Optional parameter to enable generating financial report.
    /// - When this value is set, datalink will be give an option to redirect financial report at the end of journey.
    /// - Note: Defaults to false.
    public let generateFinancialReport: Bool?
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case allowMultipleConsent = "allow_multiple_consent"
        case generateFinancialReport = "generate_financial_report"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - autoRedirect: Determines if the PSU will see a completed page by Ecospend.
    ///     - generateQrCode: Optional parameter for getting a QRCode image in Base64 format with the response.
    ///     - allowMultipleConsent: Optional parameter for allowing user to create consent multiply.
    ///     - generateFinancialReport: Optional parameter to enable generating financial report.
    public init(autoRedirect: Bool?,
                generateQrCode: Bool?,
                allowMultipleConsent: Bool?,
                generateFinancialReport: Bool?) {
        self.autoRedirect = autoRedirect
        self.generateQrCode = generateQrCode
        self.allowMultipleConsent = allowMultipleConsent
        self.generateFinancialReport = generateFinancialReport
    }
}

// MARK: - FinancialReport
/// Options that are about financial reporting for Datalink.
public struct FinancialReport: Codable {
    
    /// Optional parameters to filter financial report.
    public let filters: Filters?
    
    /// Optional parameters to add more information for financial report.
    public let parameters: FinancialReportParameters?
    
    /// Optional parameters to modify response of financial report.
    public let outputSettings: OutputSettings?
    
    enum CodingKeys: String, CodingKey {
        case filters = "filters"
        case parameters = "parameters"
        case outputSettings = "output_settings"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - filters: Instance's `Filters`, which is optional parameters to filter financial report.
    ///     - parameters: Instance's `FinancialReportParameters`, which is optional parameters to add more information for financial report.
    ///     - outputSettings: Instance's `OutputSettings`, which is optional parameters to modify response of financial report.
    public init(filters: Filters?,
                parameters: FinancialReportParameters?,
                outputSettings: OutputSettings?) {
        self.filters = filters
        self.parameters = parameters
        self.outputSettings = outputSettings
    }
}

// MARK: - FinancialReportParameters
/// Parameters to add more information about financial report for Datalink.
public struct FinancialReportParameters: Codable {
    
    /// Optional parameters to add affordability information about financial report.
    public let affordability: [AffordabilityParameters]?
    
    /// Optional parameters to verification some information about financial report.
    public let verification: VerificationParameters?
    
    /// Optional parameters to add financial information about financial report.
    public let financial: FinancialMultiParameters?
    
    /// Optional parameters to add category aggregation information about financial report.
    public let categoryAggregation: CategoryAggregationParameters?
    
    enum CodingKeys: String, CodingKey {
        case affordability
        case verification
        case financial
        case categoryAggregation = "category_aggregation"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - affordability: Instance's array of `AffordabilityParameters`, which is optional parameters to add affordability information about financial report.
    ///     - verification: Instance's `VerificationParameters`, which is optional parameters to verification some information about financial report.
    ///     - financial: Instance's `FinancialMultiParameters`, which is  optional parameters to add financial information about financial report.
    ///     - categoryAggregation: Instance's `CategoryAggregationParameters`, which is optional parameters to add category aggregation information about financial report.
    public init(affordability: [AffordabilityParameters]?,
                verification: VerificationParameters?,
                financial: FinancialMultiParameters?,
                categoryAggregation: CategoryAggregationParameters?) {
        self.affordability = affordability
        self.verification = verification
        self.financial = financial
        self.categoryAggregation = categoryAggregation
    }
}

// MARK: - CategoryAggregationParameters
/// Parameters to add category aggregation information about financial report for Datalink.
public struct CategoryAggregationParameters: Codable {
    
    /// Optional parameter to distrubution period information about financial report.
    public let distributionPeriod: DistrubutionPeriod?
    
    enum CodingKeys: String, CodingKey {
        case distributionPeriod = "distribution_period"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - distributionPeriod: Instance's `DistrubutionPeriod`, which is optional parameter to distrubution period information about financial report.
    public init(distributionPeriod: DistrubutionPeriod?) {
        self.distributionPeriod = distributionPeriod
    }
}

// MARK: - DistrubutionPeriod
/// Distrubution periods about financial report for Datalink.
public enum DistrubutionPeriod: String, Codable {
    
    /// Month.
    case month
    
    /// Quarter.
    case quarter
    
    /// Year.
    case year
}

// MARK: - AffordabilityType
/// Parameters to add affordability information about financial report for Datalink.
public struct AffordabilityParameters: Codable {
    
    /// Types of affordability information about financial report.
    public let type: [AffordabilityType]?
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - type: Instance's array of `AffordabilityType`, which is types of affordability information about financial report.
    public init(type: [AffordabilityType]?) {
        self.type = type
    }
}

// MARK: - AffordabilityType
/// Affordability types about financial report for Datalink.
public enum AffordabilityType: String, Codable {
    
    /// Max rent.
    case maxRent = "MaxRent"
    
    /// Max installments.
    case maxInstallments = "MaxInstallments"
    
    /// Gambling limit.
    case gamblingLimit = "GamblingLimit"
}

// MARK: - VerificationParameters
/// Parameters to verification some information about financial report for Datalink.
public struct VerificationParameters: Codable {
    
    /// Provide a 'Name' for the account holder to verify agains AIS data.
    public let name: String?
    
    /// Provide an array of 'phone numbers' for the account holder to verify agains AIS data.
    public let phoneNumbers: [String]?
    
    /// Provide an 'address' for the account holder to verify agains AIS data.
    public let address: String?
    
    /// Provide an 'email address' for the account holder to verify agains AIS data.
    public let email: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumbers = "phone_numbers"
        case address
        case email
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - name: Provide a 'Name' for the account holder to verify agains AIS data.
    ///     - phoneNumbers: Provide an array of 'phone numbers' for the account holder to verify agains AIS data.
    ///     - address: Provide an 'address' for the account holder to verify agains AIS data.
    ///     - email: Provide an 'email address' for the account holder to verify agains AIS data.
    public init(name: String?,
                phoneNumbers: [String]?,
                address: String?,
                email: String?) {
        self.name = name
        self.phoneNumbers = phoneNumbers
        self.address = address
        self.email = email
    }
}

// MARK: - FinancialMultiParameters
/// Parameters to add financial information about financial report for Datalink.
public struct FinancialMultiParameters: Codable {
    
    /// Set this property to 'true' if you want Financials data included in the response.
    public let financial: Bool?
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - financial: Set this property to 'true' if you want Financials data included in the response.
    public init(financial: Bool?) {
        self.financial = financial
    }
}

// MARK: - Filters
/// Parameters to filter financial report for Datalink.
public struct Filters: Codable {
    
    /// Start date of the data which will be processed in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// - Warning: Must be set the start date of the period you want.
    public let startDate: Date?
    
    /// Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    public let currency: PayByBankCurrency?
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case currency
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - startDate: Start date of the data which will be processed in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - currency: Instance's `PayByBankCurrency`, which is currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    public init(startDate: Date?,
                currency: PayByBankCurrency?) {
        self.startDate = startDate
        self.currency = currency
    }
}

// MARK: - OutputSettings
/// Parameters to modify response of financial report for Datalink.
public struct OutputSettings: Codable {
    
    /// Depending on the value, the PII (Personal Data) will be returned or omitted from the response and the generated datalink pages.
    /// - Note: Default is 'false'
    public let displayPii: Bool?
    
    enum CodingKeys: String, CodingKey {
        case displayPii = "display_pii"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - displayPii: Depending on the value, the PII (Personal Data) will be returned or omitted from the response and the generated datalink pages.
    public init(displayPii: Bool?) {
        self.displayPii = displayPii
    }
}
