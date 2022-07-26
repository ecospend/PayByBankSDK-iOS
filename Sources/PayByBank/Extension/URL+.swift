//
//  URL+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 28.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

extension URL {
    
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
