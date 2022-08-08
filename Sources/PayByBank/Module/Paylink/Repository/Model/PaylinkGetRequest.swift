//
//  PayByBankGetRequest.swift
//  PayByBankMobileSDK
//
//  Created by Yunus TÜR on 21.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkGetRequest
/// Request model to get Paylink.
public struct PaylinkGetRequest: Codable {
    
    /// Unique id value to query Paylink.
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value to get Paylink.
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
