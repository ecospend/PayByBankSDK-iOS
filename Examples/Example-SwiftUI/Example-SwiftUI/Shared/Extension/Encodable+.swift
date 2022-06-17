//
//  Encodable+.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 16.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Encodable {
    
    var jsonString: String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let jsonData = try? encoder.encode(self) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}
