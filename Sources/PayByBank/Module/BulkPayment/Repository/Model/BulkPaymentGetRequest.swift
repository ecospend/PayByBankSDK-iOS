//
//  BulkPaymentGetRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - BulkPaymentGetRequest
/// Request model to get Bulk Payment Paylink.
public struct BulkPaymentGetRequest: Codable {
    
    /// Unique id value to query Bulk Payment Paylink.
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value to query Bulk Payment Paylink.
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
