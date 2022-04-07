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
    
    /// Paylink ID to query
    public let paylinkID: String
    
    public init(paylinkID: String) {
        self.paylinkID = paylinkID
    }
    
    enum CodingKeys: String, CodingKey {
        case paylinkID = "paylink_id"
    }
}
