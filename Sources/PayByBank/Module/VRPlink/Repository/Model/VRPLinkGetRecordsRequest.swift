//
//  VRPlinkGetRecordsRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - VRPlinkGetRecordsRequest
/// Request model to get records for VRPlink.
public struct VRPlinkGetRecordsRequest: Codable {
    
    /// Unique id value to get records for VRPlink
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value to delete VRPlink
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
