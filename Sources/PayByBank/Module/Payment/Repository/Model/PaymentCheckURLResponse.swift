//
//  PaymentCheckURLResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentCheckURLResponse
public struct PaymentCheckURLResponse: Codable {
    
    /// Indicates the current status of the `paymentURL`.
    /// - Note: true: the `paymentURL` is no longer valid.
    /// - Note: false: the `paymentURL` is available (The payment_url has a lifespan that is managed by each bank differently. Even the url is not consumed it may be expired by the bank.) to use.
    public let isConsumed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case isConsumed = "is_consumed"
    }
    
    public init(isConsumed: Bool?) {
        self.isConsumed = isConsumed
    }
}
