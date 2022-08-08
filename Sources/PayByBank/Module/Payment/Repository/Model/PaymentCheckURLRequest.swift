//
//  PaymentCheckURLRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCheckURLRequest
/// Request model to check url of Payment.
public struct PaymentCheckURLRequest: Codable {
    
    /// Unique id value to query Payment.
    public let id: String
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - id: Unique id value to query Payment.
    public init(id: String) {
        self.id = id
    }
}
