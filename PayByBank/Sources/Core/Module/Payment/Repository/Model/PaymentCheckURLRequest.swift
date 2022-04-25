//
//  PaymentCheckURLRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCheckURLRequest
public struct PaymentCheckURLRequest: Codable {
    
    /// Unique id value to query Payment
    public let id: String
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    public init(id: String) {
        self.id = id
    }
}
