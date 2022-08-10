//
//  PayByBankState.swift
//  PayByBank
//
//  Created by Yunus TÜR on 16.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

struct PayByBankState {
    
    struct Config {
        static var environment: PayByBankEnvironment = .sandbox
        static var authentication: PayByBankAuthentication?
    }
    
    struct Network {
        static var token: IamTokenResponse?
    }
}
