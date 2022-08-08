//
//  DatalinkGetConsentDatalinkRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetConsentDatalinkRequest
/// Request model to get Datalink of a Consent.
public struct DatalinkGetConsentDatalinkRequest: Codable {
    
    /// ID of the account access correspanding Gateway account access consent reference
    public let consentID: String
    
    enum CodingKeys: String, CodingKey {
        case consentID = "consent_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - consentID: ID of the account access correspanding Gateway account access consent reference
    public init(consentID: String) {
        self.consentID = consentID
    }
}
