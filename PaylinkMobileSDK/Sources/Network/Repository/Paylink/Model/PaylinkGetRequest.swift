//
//  PaylinkGetRequest.swift
//  PaylinkMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//

import Foundation

// MARK: - PaylinkGetRequest
public struct PaylinkGetRequest: Codable {
    
    /// Paylink ID to query
    public let paylinkID: String
    
    public init(paylinkID: String) {
        self.paylinkID = paylinkID
    }
   
    enum CodingKeys: String, CodingKey {
        case paylinkID = "paylink_id"
    }
}
