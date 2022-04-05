//
//  PayByBank.swift
//  Paylink
//
//  Created by Yunus TÜR on 4.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

public final class PayByBank {
    private init() { }
}

// MARK: - API
public extension PayByBank {
    
    /// - Parameters:
    ///     - environment: Enum "Sandbox" "Production"
    ///     - clientID: Unique identification string assigned to the client by our system
    ///     - clientSecret: Secret string assigned to the client by our system
    static func configure(environment: PaylinkEnvironment, clientID: String, clientSecret: String) {
        // Configuration
        PaylinkState.Config.environment = environment
        PaylinkState.Config.clientID = clientID
        PaylinkState.Config.clientSecret = clientSecret
    }
    
    static var paylink: Paylink {
        return Paylink(factory: PaylinkFactory(payByBankFactory: PayByBankFactory()))
    }
}
