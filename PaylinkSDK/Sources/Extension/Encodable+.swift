//
//  Encodable+.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var jsonData: Data? {
        try? JSONEncoder().encode(self)
    }
    
    var formData: Data? {
        try? URLEncodedFormEncoder().encode(self)
    }
}
