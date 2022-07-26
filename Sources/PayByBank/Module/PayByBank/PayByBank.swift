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
    
    /// Sets configuration for all PayByBank APIs
    ///
    /// - Warning: This method should be called before using any PayByBank API, otherwise each API returns an error as `PayByBankError.notConfigured`.
    ///
    /// - Parameters:
    ///     - environment: Enum "Sandbox" "Production"
    ///     - clientID: Unique identification string assigned to the client by our system
    ///     - clientSecret: Secret string assigned to the client by our system
    static func configure(environment: PayByBankEnvironment, clientID: String, clientSecret: String) {
        PayByBankState.Config.environment = environment
        PayByBankState.Config.clientID = clientID
        PayByBankState.Config.clientSecret = clientSecret
    }
    
    /// Paylink API
    static var paylink: Paylink {
        return Paylink(factory: PaylinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// FrPayment API
    static var frPayment: FrPayment {
        return FrPayment(factory: FrPaymentFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// VRPlink API
    static var vrplink: VRPlink {
        return VRPlink(factory: VRPlinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// BulkPayment API
    static var bulkPayment: BulkPayment {
        return BulkPayment(factory: BulkPaymentFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// Datalink API
    static var datalink: Datalink {
        return Datalink(factory: DatalinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// Payment API
    static var payment: Payment {
        return Payment(factory: PaymentFactory(payByBankFactory: PayByBankFactory()))
    }
}
