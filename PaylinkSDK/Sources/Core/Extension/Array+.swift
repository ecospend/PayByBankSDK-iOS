//
//  Array+.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 3.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Array where Element: Any {
    
    func toCVarArg() -> [CVarArg] {
        return self.map { String(describing: $0) }
    }
}
