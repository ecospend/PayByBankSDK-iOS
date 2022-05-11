//
//  Bundle+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 11.05.2022.
//

import Foundation

extension Bundle {
    
#if !SWIFT_PACKAGE
    static var module: Bundle {
        return Bundle(for: PayByBank.self)
    }
#endif
}
