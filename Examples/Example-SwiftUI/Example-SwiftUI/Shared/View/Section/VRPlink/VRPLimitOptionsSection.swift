//
//  VRPLimitOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPLimitOptionsSection: View {
    
    @AppStorage(Self.storage(key: .limitOptionsCurrency)) var currency: PayByBankCurrency = .pound
    @AppStorage(Self.storage(key: .limitOptionsSinglePaymentAmount)) var singlePaymentAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsDailyAmount)) var dailyAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsWeeklyAmount)) var weeklyAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsFortnightlyAmount)) var fortnightlyAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsMonthlyAmount)) var monthlyAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsHalfYearlyAmount)) var halfYearlyAmount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsYearlyAmount)) var yearlyAmount: Decimal = 0
    
    @AppStorage(Self.storage(key: .limitOptionsDailyAlignment)) var dailyAlignment: VRPAlignment = .consent
    @AppStorage(Self.storage(key: .limitOptionsWeeklyAlignment)) var weeklyAlignment: VRPAlignment = .consent
    @AppStorage(Self.storage(key: .limitOptionsFortnightlyAlignment)) var fortnightlyAlignment: VRPAlignment = .consent
    @AppStorage(Self.storage(key: .limitOptionsMonthlyAlignment)) var monthlyAlignment: VRPAlignment = .consent
    @AppStorage(Self.storage(key: .limitOptionsHalfYearlyAlignment)) var halfYearlyAlignment: VRPAlignment = .consent
    @AppStorage(Self.storage(key: .limitOptionsYearlyAlignment)) var yearlyAlignment: VRPAlignment = .consent
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: VRPLimitOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Menu(currency.rawValue) {
                        Button(PayByBankCurrency.pound.rawValue) { currency = .pound }
                        Button(PayByBankCurrency.euro.rawValue) { currency = .euro }
                        Button(PayByBankCurrency.usd.rawValue) { currency = .usd }
                    }
                    .titled(L10n.inputLimitOptionsCurrency.localized)
                    TextField("", value: $singlePaymentAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsSinglePaymentAmount.localized)
                    TextField("", value: $dailyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsDailyAmount.localized)
                    TextField("", value: $weeklyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsWeeklyAmount.localized)
                    TextField("", value: $fortnightlyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsFortnightlyAmount.localized)
                    TextField("", value: $monthlyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsMonthlyAmount.localized)
                    TextField("", value: $halfYearlyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsHalfYearlyAmount.localized)
                    TextField("", value: $yearlyAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsYearlyAmount.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
                
                Group {
                    Menu(dailyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { dailyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { dailyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsDailyAlignment.localized)
                    Menu(weeklyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { weeklyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { weeklyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsWeeklyAlignment.localized)
                    Menu(fortnightlyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { fortnightlyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { fortnightlyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsFortnightlyAlignment.localized)
                    Menu(monthlyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { monthlyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { monthlyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsMonthlyAlignment.localized)
                    Menu(halfYearlyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { halfYearlyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { halfYearlyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsHalfYearlyAlignment.localized)
                    Menu(yearlyAlignment.rawValue) {
                        Button(VRPAlignment.consent.rawValue) { yearlyAlignment = .consent }
                        Button(VRPAlignment.calendar.rawValue) { yearlyAlignment = .calendar }
                    }
                    .titled(L10n.inputLimitOptionsYearlyAlignment.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: currency) { _ in validate() }
        .onChange(of: singlePaymentAmount) { _ in validate() }
        .onChange(of: dailyAmount) { _ in validate() }
        .onChange(of: weeklyAmount) { _ in validate() }
        .onChange(of: fortnightlyAmount) { _ in validate() }
        .onChange(of: monthlyAmount) { _ in validate() }
        .onChange(of: halfYearlyAmount) { _ in validate() }
        .onChange(of: yearlyAmount) { _ in validate() }
        .onChange(of: dailyAlignment) { _ in validate() }
        .onChange(of: weeklyAlignment) { _ in validate() }
        .onChange(of: fortnightlyAlignment) { _ in validate() }
        .onChange(of: monthlyAlignment) { _ in validate() }
        .onChange(of: halfYearlyAlignment) { _ in validate() }
        .onChange(of: yearlyAlignment) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionLimitOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return VRPLimitOptions(currency: currency,
                                   singlePaymentAmount: singlePaymentAmount > 0 ? singlePaymentAmount : nil,
                                   dailyAmount: dailyAmount > 0 ? dailyAmount : nil,
                                   weeklyAmount: weeklyAmount > 0 ? weeklyAmount : nil,
                                   fortnightlyAmount: fortnightlyAmount > 0 ? fortnightlyAmount : nil,
                                   monthlyAmount: monthlyAmount > 0 ? monthlyAmount : nil,
                                   halfYearlyAmount: halfYearlyAmount > 0 ? halfYearlyAmount : nil,
                                   yearlyAmount: yearlyAmount > 0 ? yearlyAmount : nil,
                                   dailyAlignment: dailyAlignment,
                                   weeklyAlignment: weeklyAlignment,
                                   fortnightlyAlignment: fortnightlyAlignment,
                                   monthlyAlignment: monthlyAlignment,
                                   halfYearlyAlignment: halfYearlyAlignment,
                                   yearlyAlignment: yearlyAlignment)
        }()
    }
}

struct VRPLimitOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        VRPLimitOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
