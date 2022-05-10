//
//  PayByBankColors.swift
//  PayByBank
//
//  Created by Yunus TÜR on 10.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

enum PayByBankColors: String {
    case navigationBarBackground
    case viewBackground
}

extension PayByBankColors {
    
    var color: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: self.rawValue, in: Bundle(for: Paylink.self), compatibleWith: nil)
        } else {
            switch self {
            case .navigationBarBackground,
                    .viewBackground:
                return .white
            }
        }
    }
}
