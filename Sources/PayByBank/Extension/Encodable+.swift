//
//  Encodable+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

extension Encodable {
    
    func dictionary(jsonEncoder: JSONEncoder) -> [String: Any]? {
        guard let data = try? jsonEncoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func jsonData(jsonEncoder: JSONEncoder) -> Data? {
        try? jsonEncoder.encode(self)
    }
    
    func formData(jsonEncoder: JSONEncoder) -> Data? {
        dictionary(jsonEncoder: jsonEncoder)?.formData
    }
}
