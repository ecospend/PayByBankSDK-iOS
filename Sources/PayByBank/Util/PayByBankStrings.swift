//
//  PayByBankStrings.swift
//  PayByBank
//
//  Created by Yunus TÜR on 3.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum PayByBankStrings {
    case paybybank_error_wrong_link
    
}

extension PayByBankStrings {
    
    var name: String {
        String("\(self)".split(separator: "(").first ?? "")
    }
    
    var arguments: [CVarArg]? {
        switch self {
        default: return nil
        }
    }
    
    var localized: String {
        let value = NSLocalizedString(name,
                                      tableName: PayByBankConstant.Localizable.tableName,
                                      bundle: .module,
                                      comment: "")
        guard let arguments = arguments else { return value }
        return String(format: value, arguments: arguments.map { String(describing: $0) })
    }
}
