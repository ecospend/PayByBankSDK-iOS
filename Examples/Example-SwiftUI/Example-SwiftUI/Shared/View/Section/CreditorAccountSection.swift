//
//  CreditorAccountSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct CreditorAccountSection: View {
    
    @AppStorage(Self.storage(key: .creditorAccountType)) private var type: PayByBankAccountType = .sortCode
    @AppStorage(Self.storage(key: .creditorAccountIdentification)) private var identification: String = ""
    @AppStorage(Self.storage(key: .creditorAccountName)) private var name: String = ""
    @AppStorage(Self.storage(key: .creditorAccountCurrency)) private var currency: PayByBankCurrency = .pound
    
    @State private var isEnabled: Bool = false
    @State private(set) var isRequired: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: PayByBankAccountRequest?
    
    var body: some View {
        Section(header: header) {
            Group {
                Menu(type.rawValue) {
                    Button(PayByBankAccountType.sortCode.rawValue) { type = .sortCode }
                    Button(PayByBankAccountType.iban.rawValue) { type = .iban }
                    Button(PayByBankAccountType.bban.rawValue) { type = .bban }
                }
                .titled(L10n.inputCreditorAccountIdentification.localized.required)
                TextField("", text: $identification)
                    .titled(L10n.inputCreditorAccountIdentification.localized.required)
                TextField("", text: $name)
                    .titled(L10n.inputCreditorAccountName.localized.required)
                Menu(currency.rawValue) {
                    Button(PayByBankCurrency.pound.rawValue) { currency = .pound }
                    Button(PayByBankCurrency.euro.rawValue) { currency = .euro }
                    Button(PayByBankCurrency.usd.rawValue) { currency = .usd }
                }
                .titled(L10n.inputCreditorAccountCurrency.localized.required)
            }
            .disabled(!isEnabled)
            .opacity(!isEnabled ? 0.5 : 1)
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: type) { _ in validate() }
        .onChange(of: identification) { _ in validate() }
        .onChange(of: name) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        switch isRequired {
        case true: Text(L10n.sectionCreditorAccount.localized.required)
                .onAppear { isEnabled = true }
        case false: Toggle(L10n.sectionCreditorAccount.localized, isOn: $isEnabled)
        }
    }
    
    func validate() {
        isValid = {
            guard isEnabled else { return true }
            guard !identification.isBlank, !name.isBlank else { return false  }
            return true
        }()
        
        value = {
            guard isEnabled else { return nil }
            return PayByBankAccountRequest(type: type,
                                           identification: identification,
                                           name: name,
                                           currency: currency)
        }()
    }
}

struct CreditorAccountSection_Previews: PreviewProvider {
    static var previews: some View {
        CreditorAccountSection(isValid: .constant(true), value: .constant(nil))
    }
}
