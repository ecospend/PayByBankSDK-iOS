//
//  PayByBank.swift
//  PayByBank
//
//  Created by Yunus TÜR on 4.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public final class PayByBank {
    private init() { }
}

// MARK: - API
public extension PayByBank {
    
    /// - Parameters:
    ///     - environment: Enum "Sandbox" "Production"
    ///     - clientID: Unique identification string assigned to the client by our system
    ///     - clientSecret: Secret string assigned to the client by our system
    static func configure(environment: PayByBankEnvironment, clientID: String, clientSecret: String) {
        PayByBankState.Config.environment = environment
        PayByBankState.Config.clientID = clientID
        PayByBankState.Config.clientSecret = clientSecret
    }
    
    static var paylink: Paylink {
        return Paylink(factory: PaylinkFactory(payByBankFactory: PayByBankFactory()))
    }
}
