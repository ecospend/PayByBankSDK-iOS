//
//  VRPlinkDeleteRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - VRPlinkDeleteRequest
public struct VRPlinkDeleteRequest: Codable {
    
    /// Unique id value to delete VRPlink
    public let uniqueID: String
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
}
