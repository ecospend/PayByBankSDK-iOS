//
//  PayByBank.swift
//  PayByBank
//
//  Created by Yunus TÜR on 4.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit

// MARK: - PayByBank
/// PayByBank SDK.
/// - Note: The Ecospend Gateway presents PayByBank SDK as an alternative and easier form of Open Banking Instant Payment solutions. PayByBank SDK provides you the option of downsizing the development effort for a PIS and AIS journeys to a single SDK integration. PayByBank undertakes all of interaction in the payment user journey with your branding on display.
public final class PayByBank {
    private init() { }
}

// MARK: - API
extension PayByBank {
    
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

// MARK: - WebView
public extension PayByBank {
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of Paylink.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Paylink.
    ///     - url: Unique Paylink URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of the paylink journey.
    ///     - viewController:  Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(paylink uniqueID: String,
                     url: URL,
                     redirectURL: URL,
                     viewController: UIViewController,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.paylink.open(uniqueID: uniqueID,
                              url: url,
                              redirectURL: redirectURL,
                              viewController: viewController,
                              completion: completion)
        }
    }
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of FrPayment.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the FrPayment.
    ///     - url: Unique FrPayment URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - viewController: Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(frPayment uniqueID: String,
                     url: URL,
                     redirectURL: URL,
                     viewController: UIViewController,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.frPayment.open(uniqueID: uniqueID,
                                url: url,
                                redirectURL: redirectURL,
                                viewController: viewController,
                                completion: completion)
        }
    }
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of VRPlink.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the VRPlink.
    ///     - url: Unique VRPlink URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - viewController: Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(vrplink uniqueID: String,
                     url: URL,
                     redirectURL: URL,
                     viewController: UIViewController,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.vrplink.open(uniqueID: uniqueID,
                              url: url,
                              redirectURL: redirectURL,
                              viewController: viewController,
                              completion: completion)
        }
    }
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of BulkPayment Paylink.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Bulk Payment Paylink.
    ///     - url: Unique Bulk Payment Paylink URL that you will need to redirect PSU in order the payment to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of payment process.
    ///     - viewController: Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(bulkPayment uniqueID: String,
                     url: URL,
                     redirectURL: URL,
                     viewController: UIViewController,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.bulkPayment.open(uniqueID: uniqueID,
                                  url: url,
                                  redirectURL: redirectURL,
                                  viewController: viewController,
                                  completion: completion)
        }
    }
    
    /// Opens webview using with `uniqueID`, `url` and `redirectURL` of Datalink.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Datalink.
    ///     - url: Unique Datalink URL that you will need to redirect PSU in order the account access consent to proceed.
    ///     - redirectURL: The URL of the Tenant that the PSU will be redirected at the end of account access process.
    ///     - viewController: Instance's `UIViewController`, which provides to present bank selection.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(datalink uniqueID: String,
                     url: URL,
                     redirectURL: URL,
                     viewController: UIViewController,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.datalink.open(uniqueID: uniqueID,
                               url: url,
                               redirectURL: redirectURL,
                               viewController: viewController,
                               completion: completion)
        }
    }
    
    /// Opens bank application or bank website using with `id` and`url (payment_url)` of Payment.
    ///
    /// - Parameters:
    ///     - id: A system assigned unique identification for the Payment.
    ///     - url (payment_url): A unique and one time use only URL of the debtor's banking system. You will need to redirect PSU to this link in order the payment to proceed.
    ///     - completion: It provides to handle `PayByBankResult` or `PayByBankError`.
    static func open(payment id: String,
                     url: URL,
                     completion: @escaping (Result<PayByBankResult, PayByBankError>) -> Void) {
        PayByBankConstant.GCD.dispatchQueue.async {
            self.payment.open(id: id, url: url, completion: completion)
        }
    }
}
