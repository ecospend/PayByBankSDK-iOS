//
//  Decimal+.swift
//  Example
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Decimal: RawRepresentable {
    
    public var rawValue: String {
        String(describing: self)
    }
    
    public init?(rawValue: String) {
        self = Decimal(string: rawValue) ?? 0.0
    }
}

