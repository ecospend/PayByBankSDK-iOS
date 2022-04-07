//
//  FrPaymentGetRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - FrPaymentGetRequest
public struct FrPaymentGetRequest: Codable {
    
    /// FrPayment ID to query
    public let frPaymentID: String
    
    public init(frPaymentID: String) {
        self.frPaymentID = frPaymentID
    }
    
    enum CodingKeys: String, CodingKey {
        case frPaymentID = "fr_payment_id"
    }
}
