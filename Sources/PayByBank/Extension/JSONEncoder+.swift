//
//  JSONEncoder+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 27.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public extension JSONEncoder.DateEncodingStrategy {
    
    /// Date encoding strategy for [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) with fractional seconds.
    static let iso8601withFractionalSeconds = custom {
        var container = $1.singleValueContainer()
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        try container.encode(iso8601DateFormatter.string(from: $0))
    }
}
