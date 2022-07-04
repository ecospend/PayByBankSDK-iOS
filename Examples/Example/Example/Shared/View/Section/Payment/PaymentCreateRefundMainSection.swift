//
//  PaymentCreateRefundMainSection.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentCreateRefundMainSection: View {
    
    @AppStorage(Self.storage(key: .id)) private var id: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .amount)) private var amount: Decimal = 0
    @AppStorage(Self.storage(key: .currency)) private var currency: PayByBankCurrency = .pound
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaymentCreateRefundMainSectionModel?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $id)
                    .titled(L10n.inputID.localized.required)
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
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
            }
        }
        .onChange(of: id) { _ in validate() }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: amount) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onChange(of: redirectURL) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = {
            guard !id.isBlank, !bankID.isBlank, amount > 0, !reference.isBlank, redirectURL.isURL else { return false }
            return true
        }()
        
        value = PaymentCreateRefundMainSectionModel(id:id,
                                                    bankID: bankID,
                                                    amount: amount,
                                                    currency: currency,
                                                    reference: reference,
                                                    description: !description.isBlank ? description : nil,
                                                    redirectURL: redirectURL)
    }
}

struct PaymentCreateRefundMainSection_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCreateRefundMainSection(valid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct PaymentCreateRefundMainSectionModel {
    let id: String
    let bankID: String
    let amount: Decimal
    let currency: PayByBankCurrency
    let reference: String
    let description: String?
    let redirectURL: String
}
