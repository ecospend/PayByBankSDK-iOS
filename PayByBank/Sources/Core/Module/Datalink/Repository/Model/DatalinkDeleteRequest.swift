//
//  DatalinkDeleteRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkDeleteRequest
struct DatalinkDeleteRequest: Codable {
    
    let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
}
