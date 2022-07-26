//
//  Array+.swift
//  Example
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

extension Array where Element: Any {
    
    func toCVarArgs() -> [CVarArg] {
        return self.map { String(describing: $0) }
    }
}
