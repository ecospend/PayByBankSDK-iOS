//
//  PaylinkDeleteRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkDeleteRequest
public struct PaylinkDeleteRequest: Codable {
    
    /// Unique id value to delete Paylink
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}