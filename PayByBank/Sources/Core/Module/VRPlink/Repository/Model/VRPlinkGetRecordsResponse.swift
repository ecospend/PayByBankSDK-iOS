//
//  VRPlinkGetRecordsResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public typealias VRPlinkGetRecordsResponse = [VRPlinkRecord]

// MARK: - VRPlinkRecord
public struct VRPlinkRecord: Codable {
    
    /// Paylink Id of the payment
    public let uniqueID: String?
    
    /// Client Id of the payment
    public let clientID: String?
    
    /// Tenant id of the API consumer
    public let tenantID: Int?
    
    /// A system assigned unique identification for the payment. You may need to use this id to query payments or initiate a refund.
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank. Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// A unique and one time use only URL from the PSU’s bank. You will need to redirect the PSU to this link for them to authorise a payment.
    public let dateCreated: String?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    /// Status of the VRP flow
    /// - Enum: "Initial" "AwaitingAuthorization" "Authorised" "Revoked" "Expired" "Canceled" "Failed" "Rejected" "Abandoned"
    public let status: String?
    
    /// The description that you provided with the request (if any).
    public let description: String?
    
    /// The reference that you provided with the request.
    public let reference: String?
    
    /// The merchantID that you provided with the request (if any).
    public let merchantID: String?
    
    /// The merchantUserID that you provided with the request (if any).
    public let merchantUserID: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Enum: "Sweeping" "Vrp"
    public let type: VRPType?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PaylinkAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PaylinkAccountResponse?
    
    /// Failure reason of the failed payments
    public let failureMessage: String?
    
    /// Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validFrom: String?
    
    /// ndicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validTo: String?
    
    /// If you are set true, no redirect after vrp.
    public let dontRedirect: Bool?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case clientID = "client_id"
        case tenantID = "tenant_id"
        case id = "id"
        case bankReferenceID = "bank_reference_id"
        case dateCreated = "date_created"
        case bankID = "bank_id"
        case status = "status"
        case description = "description"
        case reference = "reference"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case redirectURL = "redirect_url"
        case type = "type"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case failureMessage = "failure_message"
        case validFrom = "valid_from"
        case validTo = "valid_to"
        case dontRedirect = "dont_redirect"
    }
}

// MARK: - VRPStatus
public enum VRPStatus: String, Codable {
    /// Reques' is made but a response is not provided yet.
    case initial = "Initial"
    
    /// A response, including bank's vrp URL is returned and the PSU is expected to authorise the consent.
    case awaitingAuthorization = "AwaitingAuthorization"
    
    /// The PSU has authorized the vrp from their banking system.
    case authorised = "Authorised"
    
    /// The PSU has revoked the vrp.
    case revoked = "Revoked"
    
    /// VRP has expired.
    case expired = "Expired"
    
    /// The PSU has cancelled the VRP flow.
    case canceled = "Canceled"
    
    /// VRP flow has failed due to an error.
    case failed = "Failed"
    
    /// Bank has rejected the VRP.
    case rejected = "Rejected"
    
    /// The PSU has deserted the vrp journey prior to being redirected back from the bank.
    case abandoned = "Abandoned"
}
