//
//  Encodable+.swift
//  PaylinkMobileSDK-iOS
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
