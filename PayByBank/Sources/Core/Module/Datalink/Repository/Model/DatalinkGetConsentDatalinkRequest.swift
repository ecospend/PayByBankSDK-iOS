//
//  DatalinkGetConsentDatalinkRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetConsentDatalinkRequest
struct DatalinkGetConsentDatalinkRequest: Codable {
    
    let consentId: Bool
    
    enum CodingKeys: String, CodingKey {
        case consentId = "consent_id"
    }
}
