//
//  DatalinkGetConsentDatalinkRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetConsentDatalinkRequest
struct DatalinkGetConsentDatalinkRequest: Codable {
    
    let consentID: String
    
    enum CodingKeys: String, CodingKey {
        case consentID = "consent_id"
    }
}
