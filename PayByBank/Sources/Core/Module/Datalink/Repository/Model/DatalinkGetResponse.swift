//
//  DatalinkGetResponse.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetResponse
public struct DatalinkGetResponse: Codable {
    
    /// The URL of the Tenant that the PSU will be redirected at the end of data access process.
    public let redirectionURL: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantId: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserId: String?
    
    /// Permissions that determine which data is fetched.
    public let permissions: [ConsentPermission]?
    
    public let datalinkOptions: DatalinkOptions?
    
    public let notificationOptions: NotificationOptions?
    
    public let financialRespot: FinancialReport?
    
    public let dataLink: DatalinkModel?
    
    public let consents: [ConsentModel]?
}

// MARK: - Datalink
public struct DatalinkModel: Codable {
    
    /// A system assigned unique identification for the Datalink.
    /// - This value is also a part of the URL.
    let uniqueId: String?
    
    /// Unique Datalink URL that you will need to redirect PSU in order the data access consent to proceed.
    let url: String?
    
    /// Base64 encoded QRCode image data that represents Datalink URL.
    let qrCode: String?
    
    /// Expiry date of the link.
    let expireDate: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
        case url
        case qrCode = "qr_code"
        case expireDate = "expire_code"
    }
}

// MARK: - ConsentModel
/// Represents consent response object model.
public struct ConsentModel: Codable {
    
    /// Id of the account access correspanding Gateway account access consent reference
    public let consentId: String?
    
    public let status: ConsentStatus?
    
    /// Date of the consent creation
    public let dateCreated: String?
    
    /// The Id assigned by the Bank for the consent
    public let bankReferenceId: String?
    
    /// The date indicating when consent will be expired.
    public let consentExpiryDate: String?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankId: String?
    
    /// The date indicating when consent will end.
    public let consentEndDate: String?
}

// MARK: - ConsentStatus
public enum ConsentStatus: String, Codable {
   case initial = "Initial"
   case awaitingAuthorization = "AwaitingAuthorization"
   case authorised = "Authorised"
   case active = "Active"
   case canceled = "Canceled"
   case failed = "Failed"
   case abandoned = "Abandoned"
   case revoked = "Revoked"
   case expired = "Expired"
   case revocationPending = "RevocationPending"
}

// MARK: - ConsentPermission
public enum ConsentPermission: String, Codable {
    case account = "Account"
    case balance = "Balance"
    case trasactions = "Transactions"
    case directDebits = "DirectDebits"
    case standingOrders = "StandingOrders"
    case parties = "Parties"
    case scheduledPayments = "ScheduledPayments"
    case statements = "Statements"
    case offers = "Offers"
}
