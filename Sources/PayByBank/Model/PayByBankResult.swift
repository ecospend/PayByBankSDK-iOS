//
//  PayByBankResult.swift
//  PayByBank
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankResult
/// Result model when using open and initiate APIs.
public struct PayByBankResult: Codable {
    
    /// Unique id value of link.
    public let uniqueID: String
    
    /// Status of the process.
    /// - Enum: "Deleted" "Initiated" "Completed"
    public let status: PayByBankStatus
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value of link.
    ///     - status: Status of the process.
    public init(uniqueID: String, status: PayByBankStatus) {
        self.uniqueID = uniqueID
        self.status = status
    }
}

// MARK: - PayByBankStatus
/// Status when using open and initiate APIs.
public enum PayByBankStatus: String, Codable {
    /// Canceled the process when using open and initiate APIs.
    case canceled = "Canceled"
    
    /// Initiated the process or changed the webview url when using open and initiate APIs.
    case initiated = "Initiated"
    
    /// Redirected to bank application or bank website when using open and initiate APIs.
    case redirected = "Redirected"
}
