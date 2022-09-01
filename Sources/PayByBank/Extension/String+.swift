//
//  String+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 1.09.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension String {
    
    static func predicate(_ string: String, pattern: String) -> Bool {
        let prediction = NSPredicate(format: "SELF MATCHES %@", pattern)
        return prediction.evaluate(with: string)
    }
}
