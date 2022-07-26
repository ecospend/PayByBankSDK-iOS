//
//  DatalinkGetRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkGetRequest
public struct DatalinkGetRequest: Codable {
    
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
