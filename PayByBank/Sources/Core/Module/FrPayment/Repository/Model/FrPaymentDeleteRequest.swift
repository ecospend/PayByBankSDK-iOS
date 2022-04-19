//
//  FrPaymentDeleteRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - FrPaymentDeleteRequest
public struct FrPaymentDeleteRequest: Codable {
    
    /// Unique id value to delete FrPayment
    public let uniqueID: String
    
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
}
