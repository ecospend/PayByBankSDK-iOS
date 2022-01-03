//
//  PaylinkDeleteRequest.swift
//  PaylinkMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylınkDeleteRequest
public struct PaylinkDeleteRequest: Codable {
    
    /// Paylink ID to delete
    public let paylinkID: String
    
    public init(paylinkID: String) {
        self.paylinkID = paylinkID
    }
    
    enum CodingKeys: String, CodingKey {
        case paylinkID = "paylink_id"
    }
}
