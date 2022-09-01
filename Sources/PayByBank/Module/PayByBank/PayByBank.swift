//
//  PayByBank.swift
//  PayByBank
//
//  Created by Yunus TÜR on 4.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBank
/// PayByBank SDK.
/// - Note: The Ecospend Gateway presents PayByBank SDK as an alternative and easier form of Open Banking Instant Payment solutions. PayByBank SDK provides you the option of downsizing the development effort for a PIS and AIS journeys to a single SDK integration. PayByBank undertakes all of interaction in the payment user journey with your branding on display.
public final class PayByBank {
    private init() { }
}

// MARK: - API
public extension PayByBank {
    
    /// Sets configuration for all PayByBank APIs.
    ///
    /// - Note: For more details, please look at the [API Specifications & Developer's Guide](https://docs.ecospend.com/api/intro).
    /// - Note: Token-based authentication is a protocol which allows users to verify their identity, and in return receive a unique access token. During the life of the token, users access the Ecospend Gateway APIs. For more details, please look at [Get Access Token](https://docs.ecospend.com/api/intro/#tag/Get-Access-Token) documentation.
    ///
    /// - Warning: **Access token** should be passed before using any PayByBank API which requires authentication, otherwise, each API returns an error as `PayByBankError.notConfigured`.
    ///
    /// - Parameters:
    ///     - environment: Instance's `PayByBankEnvironment`, which is environment for testing or released applications.
    ///     - accessToken: The **Access Token** is required for all subsequent requests to the API. You should keep it safe and secure during its lifetime. The lifetime is configurable.
    ///     - tokenType: Type of token provided. Defaults to "Bearer".
    static func configure(environment: PayByBankEnvironment, accessToken: String = "", tokenType: String = "Bearer") {
        PayByBankState.Config.environment = environment
        
        PayByBankState.Config.authentication = {
            guard !accessToken.isEmpty else { return nil }
            return .token(accessToken, type: tokenType)
        }()
    }
    
    /// Paylink API
    /// - Note: The Ecospend Gateway presents Paylink as an alternative and easier form of Open Banking Instant Payment solution. Paylink provides you the option of downsizing the development effort for a PIS journey to a single endpoint integration. Paylink undertakes all of interaction in the payment user journey with your branding on display.
    static var paylink: Paylink {
        return Paylink(factory: PaylinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// FrPayment (Standing Order) API
    /// - Note: A Standing Order is an instruction that an account holder gives to their bank to make payments of a fixed amount at regular intervals. Payments are made automatically by the bank on a defined schedule (e.g. weekly or monthly) on an ongoing basis, unless a specified condition has been met, such as an end-date being reached or a set number of payments having been made. Standing Orders can only be created, amended or cancelled by the account holder, typically by using their online or telephone banking service. They are most commonly used for recurring payments where the amount stays the same, such as rent payments, subscription services or regular account top-ups.
    static var frPayment: FrPayment {
        return FrPayment(factory: FrPaymentFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// VRPlink (Variable Recurring Payment ) API
    /// - Note: Variable Recurring Payments (VRPs) let customers safely connect authorised payments providers to their bank account so that they can make payments on the customer’s behalf, in line with agreed limits. VRPs offer more control and transparency than existing alternatives, such as Direct Debit payments.
    static var vrplink: VRPlink {
        return VRPlink(factory: VRPlinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// Bulk Payment API
    /// - Note: A bulk payment is a payment created from a bulk list - so it's a payment to multiple beneficiaries from a single debit account. It will show as one debit on your bank statement. As with bulk lists, there are two types: standard domestic bulk payments and bulk Inter Account Transfers (IATs).
    static var bulkPayment: BulkPayment {
        return BulkPayment(factory: BulkPaymentFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// Datalink API
    /// - Note: Datalink is a whitelabel consent journey solution provided by Ecospend that downsizes the required implementation for the consent journey to a single endpoint integration. By making a single call to /datalink endpoint you will be able to initiate the consent journey.
    static var datalink: Datalink {
        return Datalink(factory: DatalinkFactory(payByBankFactory: PayByBankFactory()))
    }
    
    /// Payment API
    /// - Note: Domestic instant payments, international payments, and scheduled payments are all accomplished from the same /payments endpoint. The payment type is automatically identified by our system depending whether the debtor and creditor accounts are from different countries (for international payments), or whether a value has been set for the scheduled_for parameter (meaning a scheduled payment).
    static var payment: Payment {
        return Payment(factory: PaymentFactory(payByBankFactory: PayByBankFactory()))
    }
}
