//
//  VRPlinkGetRecordsResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

/// Response model to get records of VRPlink.
public typealias VRPlinkGetRecordsResponse = [VRPlinkRecord]

// MARK: - VRPlinkRecord
/// Record of VRPlink.
public struct VRPlinkRecord: Codable {
    
    /// Paylink Id of the payment.
    public let uniqueID: String?
    
    /// Client Id of the payment.
    public let clientID: String?
    
    /// Tenant id of the API consumer.
    public let tenantID: Int?
    
    /// A system assigned unique identification for the payment. You may need to use this id to query payments or initiate a refund.
    public let id: String?
    
    /// An identification number for the payment that is assigned by the bank. Can have different formats for each bank.
    public let bankReferenceID: String?
    
    /// A unique and one time use only URL from the PSU’s bank in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format. You will need to redirect the PSU to this link for them to authorise a payment.
    public let dateCreated: Date?
    
    /// Unique identification string assigned to the bank by our system.
    public let bankID: String?
    
    /// Status of the VRP flow.
    /// - Note: Enum: "Initial" "AwaitingAuthorization" "Authorised" "Revoked" "Expired" "Canceled" "Failed" "Rejected" "Abandoned"
    public let status: VRPStatus?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// - If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// - If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of payment process.
    public let redirectURL: String?
    
    /// It determines which type of payment operation will be executed by the Gateway.
    /// - Note: Enum: "Sweeping" "Vrp"
    public let type: VRPType?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// Failure reason of the failed payments.
    public let failureMessage: String?
    
    /// Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validFrom: Date?
    
    /// Indicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let validTo: Date?
    
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Paylink Id of the payment.
    ///     - clientID: Client Id of the payment.
    ///     - tenantID: Tenant id of the API consumer.
    ///     - id: A system assigned unique identification for the payment. You may need to use this id to query payments or initiate a refund.
    ///     - bankReferenceID: An identification number for the payment that is assigned by the bank. Can have different formats for each bank.
    ///     - dateCreated: A unique and one time use only URL from the PSU’s bank in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format. You will need to redirect the PSU to this link for them to authorise a payment.
    ///     - bankID:Unique identification string assigned to the bank by our system.
    ///     - status:  Instance’s `VRPStatus`,  which is status of the VRP flow.
    ///     - description: Description for the payment. 255 character MAX.
    ///     - reference: Payment reference that will be displayed on the bank statement. 18 characters MAX.
    ///     - merchantID: If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    ///     - merchantUserID: The Id of the end-user.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - type: Instance’s `VRPType`,  which determines which type of payment operation will be executed by the Gateway.
    ///     - creditorAccount:  Instance’s `PayByBankAccountResponse`, which is the account that will receive the payment.
    ///     - debtorAccount:  Instance’s `PayByBankAccountResponse`, which is the account from which the payment will be taken.
    ///     - failureMessage: Failure reason of the failed payments.
    ///     - validFrom:Indicates Validity Start Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - validTo: Indicates Validity End Date in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    ///     - dontRedirect: If you are set true, no redirect after vrp.
    public init(uniqueID: String?,
                clientID: String?,
                tenantID: Int?,
                id: String?,
                bankReferenceID: String?,
                dateCreated: Date?,
                bankID: String?,
                status: VRPStatus?,
                description: String?,
                reference: String?,
                merchantID: String?,
                merchantUserID: String?,
                redirectURL: String?,
                type: VRPType?,
                creditorAccount: PayByBankAccountResponse?,
                debtorAccount: PayByBankAccountResponse?,
                failureMessage: String?,
                validFrom: Date?,
                validTo: Date?,
                dontRedirect: Bool?) {
        self.uniqueID = uniqueID
        self.clientID = clientID
        self.tenantID = tenantID
        self.id = id
        self.bankReferenceID = bankReferenceID
        self.dateCreated = dateCreated
        self.bankID = bankID
        self.status = status
        self.description = description
        self.reference = reference
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.redirectURL = redirectURL
        self.type = type
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.failureMessage = failureMessage
        self.validFrom = validFrom
        self.validTo = validTo
        self.dontRedirect = dontRedirect
    }
}

// MARK: - VRPStatus
/// Status of the VRP flow.
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
