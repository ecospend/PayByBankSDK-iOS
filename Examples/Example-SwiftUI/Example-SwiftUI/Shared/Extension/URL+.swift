//
//  URL+.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 17.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension URL: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hashValue
    }
}
