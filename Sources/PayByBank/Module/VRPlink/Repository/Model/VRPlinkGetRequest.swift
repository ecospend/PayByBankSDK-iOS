//
//  VRPlinkGetRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - VRPlinkGetRequest
public struct VRPlinkGetRequest: Codable {
    
    /// Unique id value to query VRPlink
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}