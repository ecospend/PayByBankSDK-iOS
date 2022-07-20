//
//  String+.swift
//  Example
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension String {
    
    var required: String {
        "\(self)*"
    }
}

// MARK: - Validation
extension String {
    
    var isBlank: Bool {
        return self.replacingOccurrences(of: " ", with: "").isEmpty
    }
    
    func isBetween(min: Int, max: Int) -> Bool {
        return self.count >= min && self.count <= max
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let prediction = NSPredicate(format: "SELF MATCHES %@", regex)
        return prediction.evaluate(with: self)
    }
    
    var isPhone: Bool {
        let regex = "^[+]{1}[0-9]{0,1}+[0-9]{5,16}$"
        let prediction = NSPredicate(format: "SELF MATCHES %@", regex)
        return prediction.evaluate(with: self)
    }
    
    var isURL: Bool {
        return !self.isBlank && URL(string: self) != nil
    }
}

// MARK: - Optional
extension Optional where Wrapped == String {
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    var isNilOrBlank: Bool {
        return self?.isBlank ?? true
    }
}

// MARK: - Static
extension String {
    
    static func predicate(_ string: String, pattern: String) -> Bool {
        let prediction = NSPredicate(format: "SELF MATCHES %@", pattern)
        return prediction.evaluate(with: string)
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
