//
//  PayByBankConstant.swift
//  PayByBank
//
//  Created by Yunus TÜR on 6.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

struct PayByBankConstant {
    
    struct GCD {
        static let dispatchQueue = DispatchQueue(label: "com.ecospend.paybybank", attributes: .concurrent)
    }
    
    struct URLHost {
        static let ecospend = "ecospend.com"
        static let ecospendFull = "www.\(ecospend)"
        static let fca = "register.fca.org.uk"
    }
    
    struct Localizable {
        static let tableName = "PayByBank"
    }
}
