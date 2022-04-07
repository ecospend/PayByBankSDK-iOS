//
//  DatalinkCreateRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkCreateRequest
public struct DatalinkCreateRequest: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of account access process.
    public let redirectURL: String
    
    /// Unique identification string assigned to the bank by our system.
    /// If value is set, Datalink will not display any UI and execute an instant redirect to the debtor's banking system.
    /// If value is not set, Datalink will display the PSU a bank selection screen.
    public let bankId: String?
    
    /// If you are providing our Data service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantId: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserId: String?
    
    /// The date indicating when consent will end.
    public let consentEndDate: String?
    
    /// The date indicating when consent will expire.
    public let expiryDate: String?
    
    /// The permissions which will be asked to the users while connecting their account.
    /// Determines which data will be fetched
    /// If it is not set, system will automatically set all the permissions
    public let permissions: [String]?
    
    public let datalinkOptions: DatalinkOptions
    
    public let notificationOptions: NotificationOptions
    
    public let financialReport: FinancialReport
    
    enum CodingKeys: String, CodingKey {
        case redirectURL = "redirect_url"
        case bankId = "bank_id"
        case merchantId = "merchant_id"
        case merchantUserId = "merchant_user_id"
        case consentEndDate = "consent_end_date"
        case expiryDate = "expiry_date"
        case permissions
        case datalinkOptions = "datalink_options"
        case notificationOptions = "notification_options"
        case financialReport = "financial_report"
    }
    
    public init(redirectURL: String,
                bankId: String?,
                merchantId: String?,
                merchantUserId: String?,
                consentEndDate: String?,
                expiryDate: String?,
                permissions: [String]?,
                datalinkOptions: DatalinkOptions,
                notificationOptions: NotificationOptions,
                financialReport: FinancialReport) {
        self.redirectURL = redirectURL
        self.bankId = bankId
        self.merchantId = merchantId
        self.merchantUserId = merchantUserId
        self.consentEndDate = consentEndDate
        self.expiryDate = expiryDate
        self.permissions = permissions
        self.datalinkOptions = datalinkOptions
        self.notificationOptions = notificationOptions
        self.financialReport = financialReport
    }
}

// MARK: - DatalinkOptions
public struct DatalinkOptions: Codable {
    
    /// Determines if the PSU will see a completed page by Ecospend. If it is set true, then PSU will be redirected directly to Tenant's redirect page If it is set false, then PSU will see the consent completed page wihch provided by the Ecospend
    public let autoRedirect: Bool
    
    /// Optional parameter for getting a QRCode image in Base64 format with the response.
    /// * Defaults to false.
    public let generateQrCode: Bool
    
    /// Optional parameter for allowing user to create consent multiply
    /// - When this value is set, datalink will be ask for connect an another account at the end of journey.
    /// - Defaults to false.
    public let allowMultipleConsent: Bool
    
    /// Optional parameter to enable generating financial report
    /// - When this value is set, datalink will be give an option to redirect financial report at the end of journey.
    /// - Defaults to false.
    public let generateFinancialReport: Bool
    
    enum CodingKeys: String, CodingKey {
        case autoRedirect = "auto_redirect"
        case generateQrCode = "generate_qr_code"
        case allowMultipleConsent = "allow_multiple_consent"
        case generateFinancialReport = "generate_financial_report"
    }
    
    public init(autoRedirect: Bool,
                generateQrCode: Bool,
                allowMultipleConsent: Bool,
                generateFinancialReport: Bool) {
        self.autoRedirect = autoRedirect
        self.generateQrCode = generateQrCode
        self.allowMultipleConsent = allowMultipleConsent
        self.generateFinancialReport = generateFinancialReport
    }
}

// MARK: - NotificationOptions
public struct NotificationOptions: Codable {
    /// Optional parameter for Gateway to send an email notification to the PSU with the Datalink URL.
    /// - Defaults to false.
    public let sendEmailNotification: Bool
    
    /// The email address that the email notification will be sent to.
    /// - This field is **mandatory** if send_email_notification is true.
    public let email: String?
    
    /// Optional parameter for Gateway to send an SMS notification to the PSU with the Datalink URL.
    /// - Defaults to false.
    public let sendSMSNotification: Bool
    
    /// The phone number (including the country dial-in code) that the SMS notification will be sent to.
    /// - This field is **mandatory** if send_sms_notification is true.
    public let phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case sendEmailNotification = "send_email_notification"
        case email
        case sendSMSNotification = "send_sms_notification"
        case phoneNumber = "phone_number"
    }
    
    public init(sendEmailNotification: Bool,
                email: String?,
                sendSMSNotification: Bool,
                phoneNumber: String?) {
        self.sendEmailNotification = sendEmailNotification
        self.email = email
        self.sendSMSNotification = sendSMSNotification
        self.phoneNumber = phoneNumber
    }
}

// MARK: - FinancialReport
public struct FinancialReport: Codable {
    
    public let filters: Filters
    public let parameters: FinancialReportParameters
    public let outputSettings: OutputSettings
    
    public init(filters: Filters,
                parameters: FinancialReportParameters,
                outputSettings: OutputSettings) {
        self.filters = filters
        self.parameters = parameters
        self.outputSettings = outputSettings
    }
}

// MARK: - FinancialReportParameters
public struct FinancialReportParameters: Codable {
    
    public let affordability: [AffordabilityParameters]?
    public let verification: VerificationParameters
    public let financial: FinancialMultiParameters
    public let categoryAggregation: CategoryAggregationParameters
    
    enum CodingKeys: String, CodingKey {
        case affordability
        case verification
        case financial
        case categoryAggregation = "category_aggregation"
    }
    
    public init(affordability: [AffordabilityParameters]?,
                verification: VerificationParameters,
                financial: FinancialMultiParameters,
                categoryAggregation: CategoryAggregationParameters) {
        self.affordability = affordability
        self.verification = verification
        self.financial = financial
        self.categoryAggregation = categoryAggregation
    }
}

// MARK: - CategoryAggregationParameters
public struct CategoryAggregationParameters: Codable {
    
    public let distributionPeriod: DistrubutionPeriod
    
    enum CodingKeys: String, CodingKey {
        case distributionPeriod = "distribution_period"
    }
    
    public init(distributionPeriod: DistrubutionPeriod) {
        self.distributionPeriod = distributionPeriod
    }
}

// MARK: - DistrubutionPeriod
public enum DistrubutionPeriod: Codable {
    case month
    case quarter
    case year
}

// MARK: - AffordabilityType
public struct AffordabilityParameters: Codable {
    
    public let type: [AffordabilityType]
    
    public init(type: [AffordabilityType]) {
        self.type = type
    }
}

// MARK: - AffordabilityType
public enum AffordabilityType: String, Codable {
    case maxRent = "MaxRent"
    case maxInstallments = "MaxInstallments"
    case gamblingLimit = "GamblingLimit"
}

// MARK: - VerificationParameters
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
    
    public init(name: String?, phoneNumbers: [String]?, address: String?, email: String?) {
        self.name = name
        self.phoneNumbers = phoneNumbers
        self.address = address
        self.email = email
    }
}

// MARK: - FinancialMultiParameters
public struct FinancialMultiParameters: Codable {
    
    /// Set this property to 'true' if you want Financials data included in the response.
    public let financial: Bool
    
    public init(financial: Bool) {
        self.financial = financial
    }
}

// MARK: - Filters
public struct Filters: Codable {
    
    /// Start date of the data which will be processed. Must be set the start date of the period you want.
    public let startDate: String
    
    /// Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    public let currency: PaylinkCurrency?
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case currency
    }
    
    public init(startDate: String,
                currency: PaylinkCurrency?) {
        self.startDate = startDate
        self.currency = currency
    }
}

// MARK: - OutputSettings
public struct OutputSettings: Codable {
    
    /// Depending on the value, the PII (Personal Data) will be returned or omitted from the response and the generated datalink pages. Default is 'false'
    public let displayPii: Bool
    
    enum CodingKeys: String, CodingKey {
        case displayPii = "display_pii"
    }
    
    public init(displayPii: Bool) {
        self.displayPii = displayPii
    }
}
