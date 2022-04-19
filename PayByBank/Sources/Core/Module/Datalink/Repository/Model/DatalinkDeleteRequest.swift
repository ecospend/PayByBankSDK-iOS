//
//  DatalinkDeleteRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkDeleteRequest
public struct DatalinkDeleteRequest: Codable {
    
    public let uniqueID: String
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
}
