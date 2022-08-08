//
//  DatalinkGetResponse.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetResponse
/// Response model to get Datalink.
public struct DatalinkGetResponse: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of data access process.
    public let redirectionURL: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the ID of your merchant.
    public let merchantID: String?
    
    /// The ID of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that ID to this parameter.
    /// If you are providing this service to businesses, then you should assign the ID of that merchant’s user.
    public let merchantUserID: String?
    
    /// Permissions that determine which data is fetched.
    public let permissions: [ConsentPermission]?
    
    /// Options that are about Datalink.
    public let datalinkOptions: DatalinkOptions?
    
    /// Options that are about notification.
    public let notificationOptions: PayByBankNotificationOptionsResponse?
    
    /// Options that are about financial reporting.
    public let financialReport: FinancialReport?
    
    /// Datalink details.
    public let datalink: DatalinkModel?
    
    /// Consents which are given to this Datalink.
    public let consents: [ConsentModel]?
    
    enum CodingKeys: String, CodingKey {
        case redirectionURL = "redirect_url"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case permissions
        case datalinkOptions = "datalink_options"
        case notificationOptions = "notification_options"
        case financialReport = "financial_report"
        case datalink
        case consents
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - redirectionURL: The URL of the Tenant that the PSU will be redirected at the end of data access process.
    ///     - merchantID: If you are providing our Data service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - permissions: Instance's array of `ConsentPermission`, which will be asked to the users while connecting their account..
    ///     - datalinkOptions: Instance's `DatalinkOptions`, which contains options about Datalink.
    ///     - notificationOptions: Instance's `PayByBankNotificationOptionsResponse`, which contains options about notification.
    ///     - financialReport: Instance's `FinancialReport`, which contains options about financial reporting.
    ///     - datalink: Instance's `DatalinkModel`, which contains details of Datalink.
    ///     - consents:  Instance's array of `ConsentModel`, which is given to this Datalink.
    public init(redirectionURL: String?,
                merchantID: String?,
                merchantUserID: String?,
                permissions: [ConsentPermission]?,
                datalinkOptions: DatalinkOptions?,
                notificationOptions: PayByBankNotificationOptionsResponse?,
                financialReport: FinancialReport?,
                datalink: DatalinkModel?,
                consents: [ConsentModel]?) {
        self.redirectionURL = redirectionURL
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.permissions = permissions
        self.datalinkOptions = datalinkOptions
        self.notificationOptions = notificationOptions
        self.financialReport = financialReport
        self.datalink = datalink
        self.consents = consents
    }
}

// MARK: - Datalink
/// Datalink details.
public struct DatalinkModel: Codable {
    
    /// A system assigned unique identification for the Datalink.
    /// - Note: This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Unique Datalink URL that you will need to redirect PSU in order the data access consent to proceed.
    public let url: String?
    
    /// Base64 encoded QRCode image data that represents Datalink URL.
    public let qrCode: String?
    
    /// Expiry date of the link in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let expireDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case url
        case qrCode = "qr_code"
        case expireDate = "expire_code"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Datalink.
    ///     - url: Unique Datalink URL that you will need to redirect PSU in order the data access consent to proceed.
    ///     - qrCode: Base64 encoded QRCode image data that represents Datalink URL.
    ///     - expireDate: Expiry date of the link in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(uniqueID: String?,
                url: String?,
                qrCode: String?,
                expireDate: Date?) {
        self.uniqueID = uniqueID
        self.url = url
        self.qrCode = qrCode
        self.expireDate = expireDate
    }
}

// MARK: - ConsentModel
/// Represents consent response object model.
public struct ConsentModel: Codable {
    
    /// ID of the account access correspanding Gateway account access consent reference
    public let consentID: String?
    
    /// Consent status for Datalink.
    public let status: ConsentStatus?
    
    /// Date of the consent creation in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let dateCreated: Date?
    
    /// The ID assigned by the Bank for the consent
    public let bankReferenceID: String?
    
    /// The date indicating when consent will be expired in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let consentExpiryDate: Date?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    /// The date indicating when consent will end in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let consentEndDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case consentID = "consent_id"
        case status
        case dateCreated = "date_created"
        case bankReferenceID = "bank_reference_id"
        case consentExpiryDate = "consent_expiry_date"
        case bankID = "bank_id"
        case consentEndDate = "consent_end_date"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - consentID: ID of the account access correspanding Gateway account access consent reference
    ///     - status:  Instance's `ConsentStatus`, which is consent status for Datalink.
    ///     - dateCreated: Date of the consent creation in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - bankReferenceID: The ID assigned by the Bank for the consent
    ///     - consentExpiryDate: The date indicating when consent will be expired in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - bankID: Unique identification string assigned to the bank by our system.
    ///     - consentEndDate: The date indicating when consent will end in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public init(consentID: String?,
                status: ConsentStatus?,
                dateCreated: Date?,
                bankReferenceID: String?,
                consentExpiryDate: Date?,
                bankID: String?,
                consentEndDate: Date?) {
        self.consentID = consentID
        self.status = status
        self.dateCreated = dateCreated
        self.bankReferenceID = bankReferenceID
        self.consentExpiryDate = consentExpiryDate
        self.bankID = bankID
        self.consentEndDate = consentEndDate
    }
}

// MARK: - ConsentStatus
/// Consent statuses for Datalink.
public enum ConsentStatus: String, Codable {
    
    /// Request is made but a Response is not provided yet.
    case initial = "Initial"
    
    /// Response is returned and the PSU is expected to authorise the consent.
    case awaitingAuthorization = "AwaitingAuthorization"
    
    /// The PSU has authorized the consent from their banking system.
    case authorised = "Authorised"
    
    /// Ecospend and the PSU’s Bank verified the consent authorization.
    case active = "Active"
    
    /// The PSU has cancelled the consent flow.
    case canceled = "Canceled"
    
    /// Consent flow has failed due to an error.
    case failed = "Failed"
    
    /// The PSU has deserted the consent journey prior to being redirected back from the bank.
    case abandoned = "Abandoned"
    
    /// Consent flow is revoked.
    case revoked = "Revoked"
    
    /// Consent flow is expired.
    case expired = "Expired"
    
    /// Consent flow is waiting revocation.
    case revocationPending = "RevocationPending"
}

// MARK: - ConsentPermission
/// Permissions that determine which data is fetched for Datalink.
public enum ConsentPermission: String, Codable {
    
    /// Account.
    case account = "Account"
    
    /// Balance.
    case balance = "Balance"
    
    /// Transactions.
    case trasactions = "Transactions"
    
    /// Direct debits.
    case directDebits = "DirectDebits"
    
    /// Standing orders.
    case standingOrders = "StandingOrders"
    
    /// Parties.
    case parties = "Parties"
    
    /// Scheduled payments.
    case scheduledPayments = "ScheduledPayments"
    
    /// Statements.
    case statements = "Statements"
    
    /// Offers.
    case offers = "Offers"
}
