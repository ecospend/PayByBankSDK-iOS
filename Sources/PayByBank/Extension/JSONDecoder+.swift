//
//  JSONDecoder+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 27.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public extension JSONDecoder.DateDecodingStrategy {
    
    static let iso8601withFractionalSeconds = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = iso8601DateFormatter.date(from: string) else {
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "Invalid date: " + string)
        }
        return date
    }
}
