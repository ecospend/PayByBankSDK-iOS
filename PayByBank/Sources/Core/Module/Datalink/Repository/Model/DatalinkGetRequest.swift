//
//  DatalinkGetRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetRequest
struct DatalinkGetRequest: Codable {
    
    let uniqueId: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "unique_id"
    }
}
