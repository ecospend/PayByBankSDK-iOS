//
//  DatalinkGetConsentDatalinkRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetConsentDatalinkRequest
public struct DatalinkGetConsentDatalinkRequest: Codable {
    
    public let consentID: String
    
    enum CodingKeys: String, CodingKey {
        case consentID = "consent_id"
    }
    
    public init(consentID: String) {
        self.consentID = consentID
    }
}