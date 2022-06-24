//
//  RefundAccountSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct RefundAccountSection: View {
    
    @AppStorage(Self.storage(key: .accountType)) private var type: PayByBankAccountType = .sortCode
    @AppStorage(Self.storage(key: .accountIdentification)) private var identification: String = ""
    @AppStorage(Self.storage(key: .accountOwnerName)) private var ownerName: String = ""
    @AppStorage(Self.storage(key: .accountCurrency)) private var currency: PayByBankCurrency = .pound
    @AppStorage(Self.storage(key: .accountBic)) private var bic: String = ""
    
    @State private var isEnabled: Bool = false
    @State private(set) var isRequired: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PayByBankAccountRequest?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Menu(type.rawValue) {
                        Button(PayByBankAccountType.sortCode.rawValue) { type = .sortCode }
                        Button(PayByBankAccountType.iban.rawValue) { type = .iban }
                        Button(PayByBankAccountType.bban.rawValue) { type = .bban }
                    }
                    .titled(L10n.inputAccountType.localized.required)
                    TextField("", text: $identification)
                        .titled(L10n.inputAccountIdentification.localized.required)
                    TextField("", text: $ownerName)
                        .titled(L10n.inputAccountOwnerName.localized.required)
                    Menu(currency.rawValue) {
                        Button(PayByBankCurrency.pound.rawValue) { currency = .pound }
                        Button(PayByBankCurrency.euro.rawValue) { currency = .euro }
                        Button(PayByBankCurrency.usd.rawValue) { currency = .usd }
                    }
                    .titled(L10n.inputAccountCurrency.localized)
                    TextField("", text: $bic)
                        .titled(L10n.inputAccountBic.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: type) { _ in validate() }
        .onChange(of: identification) { _ in validate() }
        .onChange(of: ownerName) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onChange(of: bic) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        switch isRequired {
        case true: Text(L10n.sectionRefundAccount.localized.required)
                .onAppear { isEnabled = true }
        case false: Toggle(L10n.sectionRefundAccount.localized, isOn: $isEnabled)
        }
    }
    
    func validate() {
        valid = {
            guard isEnabled else { return true }
            guard !identification.isBlank, !ownerName.isBlank else { return false  }
            return true
        }()
        
        value = {
            guard isEnabled else { return nil }
            return PayByBankAccountRequest(type: type,
                                           identification: identification,
                                           name: ownerName,
                                           currency: currency,
                                           bic: !bic.isBlank ? bic : nil)
        }()
    }
}

struct RefundAccountSection_Previews: PreviewProvider {
    static var previews: some View {
        RefundAccountSection(valid: .constant(true), value: .constant(nil))
    }
}
