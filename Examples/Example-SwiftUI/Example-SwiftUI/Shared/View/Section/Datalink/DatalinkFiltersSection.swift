//
//  DatalinkFiltersSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkFiltersSection: View {
    
    @AppStorage(Self.storage(key: .startDate)) private var startDate: Date = .default
    @AppStorage(Self.storage(key: .currency)) private var currency: PayByBankCurrency = .pound
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: Filters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatePicker(selection: $startDate, displayedComponents: .date) {
                        Text(L10n.inputStartDate.localized)
                    }
                    Menu(currency.rawValue) {
                        Button(PayByBankCurrency.pound.rawValue) { currency = .pound }
                        Button(PayByBankCurrency.euro.rawValue) { currency = .euro }
                        Button(PayByBankCurrency.usd.rawValue) { currency = .usd }
                    }
                    .titled(L10n.inputAccountCurrency.localized.required)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: startDate) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionFilters.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return Filters(startDate: startDate != .default ? startDate.rawValue : nil,
                           currency: currency)
        }()
    }
}

struct DatalinkFiltersSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkFiltersSection(isValid: .constant(true), value: .constant(nil))
    }
}
