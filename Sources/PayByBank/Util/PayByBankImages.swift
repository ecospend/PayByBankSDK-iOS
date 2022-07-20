//
//  PayByBankImages.swift
//  PayByBank
//
//  Created by Yunus TÜR on 10.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

enum PayByBankImages: String {
    case close
}

extension PayByBankImages {
    
    var image: UIImage? {
        return UIImage(named: self.rawValue, in: .module, compatibleWith: nil)
    }
}
