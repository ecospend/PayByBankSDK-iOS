//
//  View+.swift
//  Example
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

extension View {
    
    static func storage(key value: AppStorageKeys) -> String {
        let type = String(reflecting: self).components(separatedBy: ".").last ?? ""
        return "\(type).\(value.rawValue)"
    }
}

extension View {
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
