//
//  Dictionary+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 19.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    var formData: Data? {
        var strings = [String]()
        for(key, value) in self
        {
            strings.append(key + "=\(String(describing: value))")
        }
        return strings.map { String($0) }.joined(separator: "&").data(using: .utf8)
    }
}
