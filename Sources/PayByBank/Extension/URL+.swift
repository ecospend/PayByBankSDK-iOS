//
//  URL+.swift
//  PayByBank
//
//  Created by Yunus TÜR on 28.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

extension URL {
    
    var isEcospendHost: Bool {
        return String.predicate(host ?? "", pattern: "^(.*)([\(PayByBankConstant.URLHost.ecospend)])")
    }
}
