//
//  PayByBankResult.swift
//  PayByBank
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankResult
public struct PayByBankResult: Codable {
    
    /// Unique id value of link.
    public let uniqueID: String
    
    /// Status of paylink.
    /// - Enum: "Deleted" "Initiated" "Completed"
    public let status: PayByBankStatus
    
    public init(uniqueID: String, status: PayByBankStatus) {
        self.uniqueID = uniqueID
        self.status = status
    }
}

// MARK: - PaylinkStatus
public enum PayByBankStatus: String, Codable {
    case canceled = "Canceled"
    case initiated = "Initiated"
    case redirected = "Redirected"
}
