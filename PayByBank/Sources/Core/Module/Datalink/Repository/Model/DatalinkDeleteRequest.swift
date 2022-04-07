//
//  DatalinkDeleteRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkDeleteRequest
struct DatalinkDeleteRequest: Codable {
    
    let uniqueId: Bool
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
    }
}
