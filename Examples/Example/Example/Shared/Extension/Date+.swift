//
//  Date+.swift
//  Example
//
//  Created by Yunus TÜR on 14.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

extension Date {
    
    static var `default`: Date {
        Date(timeIntervalSince1970: 0)
    }
}
