//
//  FrPaymentGetRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - FrPaymentGetRequest
/// Request model to get FrPayment.
public struct FrPaymentGetRequest: Codable {
    
    /// Unique id value to query FrPayment.
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: Unique id value to query FrPayment.
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
