//
//  PaymentCreateMainSection.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .amount)) private var amount: Decimal = 0
    @AppStorage(Self.storage(key: .currency)) private var currency: PayByBankCurrency = .pound
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    @AppStorage(Self.storage(key: .paymentType)) private var paymentType: PaymentType = .auto
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaymentCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
                TextField("", text: $bankID)
                    .titled(L10n.inputBankID.localized.required)
                TextField("", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .titled(L10n.inputLimitOptionsAmount.localized.required)
                Menu(currency.rawValue) {
                    Button(PayByBankCurrency.pound.rawValue) { currency = .pound }
                    Button(PayByBankCurrency.euro.rawValue) { currency = .euro }
                    Button(PayByBankCurrency.usd.rawValue) { currency = .usd }
                }
                .titled(L10n.inputAccountCurrency.localized.required)
                TextField("", text: $reference)
                    .titled(L10n.inputReference.localized.required)
                TextField("", text: $description)
                    .titled(L10n.inputDescription.localized)
                TextField("", text: $merchantID)
                    .titled(L10n.inputMerchantID.localized)
                TextField("", text: $merchantUserID)
                    .titled(L10n.inputMerchantUserID.localized)
                Menu(paymentType.rawValue) {
                    Button(PaymentType.auto.rawValue) { paymentType = .auto }
                    Button(PaymentType.domestic.rawValue) { paymentType = .domestic }
                    Button(PaymentType.domesticScheduled.rawValue) { paymentType = .domesticScheduled }
                    Button(PaymentType.international.rawValue) { paymentType = .international }
                    Button(PaymentType.internationalScheduled.rawValue) { paymentType = .internationalScheduled }
                }
                .titled(L10n.inputPaymentType.localized.required)
            }
        }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: amount) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onChange(of: paymentType) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = {
            guard redirectURL.isURL, !bankID.isBlank, amount > 0, !reference.isBlank else { return false }
            return true
        }()
        
        value = PaymentCreateMainSectionModel(redirectURL: redirectURL,
                                              bankID: bankID,
                                              amount: amount,
                                              currency: currency,
                                              reference: reference,
                                              description: !description.isBlank ? description : nil,
                                              merchantID: !merchantID.isBlank ? merchantID : nil,
                                              merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil,
                                              paymentType: paymentType)
    }
}

struct PaymentCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCreateMainSection(valid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct PaymentCreateMainSectionModel {
    let redirectURL: String
    let bankID: String
    let amount: Decimal
    let currency: PayByBankCurrency
    let reference: String
    let description: String?
    let merchantID: String?
    let merchantUserID: String?
    let paymentType: PaymentType?
}
