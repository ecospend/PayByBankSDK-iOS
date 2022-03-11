//
//  PaylinkResult.swift
//  Paylink
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkResult
public struct PaylinkResult: Codable {
    
    /// Unique id value of link.
    public let uniqueID: String
    
    /// Status of paylink.
    /// - Enum: "Deleted" "Initiated" "Completed"
    public let status: PaylinkStatus
}

// MARK: - PaylinkStatus
public enum PaylinkStatus: String, Codable {
    case deleted = "Deleted"
    case initiated = "Initiated"
    case completed = "Completed"
}
