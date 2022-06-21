//
//  FrPaymentCreateMainSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 20.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct FrPaymentCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .amount)) private var amount: Decimal = 0.0
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    @AppStorage(Self.storage(key: .firstPaymentDate)) var firstPaymentDate: Date = .now
    @AppStorage(Self.storage(key: .numberOfPayments)) var numberOfPayments: Int = 0
    @AppStorage(Self.storage(key: .period)) var period: FrPaymentPeriod = .weekly
    @AppStorage(Self.storage(key: .standingOrderType)) var standingOrderType: FrPaymentStandingOrderType = .auto
    @AppStorage(Self.storage(key: .allowFrpCustomerChanges)) var allowFrpCustomerChanges: Bool = false
    
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: FrPaymentCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
                Group {
                    TextField("", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputAmount.localized.required)
                    TextField("", text: $reference)
                        .titled(L10n.inputReference.localized.required)
                    TextField("", text: $description)
                        .titled(L10n.inputDescription.localized)
                    TextField("", text: $redirectURL)
                        .titled(L10n.inputRedirectURL.localized.required)
                    TextField("", text: $bankID)
                        .titled(L10n.inputBankID.localized)
                    TextField("", text: $merchantID)
                        .titled(L10n.inputMerchantID.localized)
                    TextField("", text: $merchantUserID)
                        .titled(L10n.inputMerchantUserID.localized)
                }
                
                Group {
                    DatePicker(selection: $firstPaymentDate, displayedComponents: .date) {
                        Text(L10n.inputFirstPaymentDate.localized.required)
                    }
                    TextField("", value: $numberOfPayments, format: .number)
                        .keyboardType(.numberPad)
                        .titled(L10n.inputNumberOfPayments.localized.required)
                    Menu(String("\(period)")) {
                        Button(String("\(FrPaymentPeriod.weekly)")) { period = .weekly }
                        Button(String("\(FrPaymentPeriod.monthly)")) { period = .monthly }
                        Button(String("\(FrPaymentPeriod.yearly)")) { period = .yearly }
                    }
                    .titled(L10n.inputPeriod.localized.required)
                    Menu(standingOrderType.rawValue) {
                        Button(FrPaymentStandingOrderType.auto.rawValue.capitalized) { standingOrderType = .auto }
                        Button(FrPaymentStandingOrderType.domestic.rawValue.capitalized) { standingOrderType = .domestic }
                        Button(FrPaymentStandingOrderType.international.rawValue.capitalized) { standingOrderType = .international }
                    }
                    .titled(L10n.inputStandingOrderType.localized)
                    Toggle(L10n.inputAllowFrpCustomerChanges.localized, isOn: $allowFrpCustomerChanges)
                }
            }
        }
        .onChange(of: amount) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onChange(of: firstPaymentDate) { _ in validate() }
        .onChange(of: numberOfPayments) { _ in validate() }
        .onChange(of: period) { _ in validate() }
        .onChange(of: standingOrderType) { _ in validate() }
        .onChange(of: allowFrpCustomerChanges) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        isValid = {
            guard amount > 0, !reference.isBlank, redirectURL.isURL, numberOfPayments > 0,
            firstPaymentDate >= .now else { return false }
            return true
        }()
        
        value = FrPaymentCreateMainSectionModel(amount: amount,
                                                reference: reference,
                                                description: !description.isBlank ? description : nil,
                                                redirectURL: redirectURL,
                                                bankID: !bankID.isBlank ? bankID : nil,
                                                merchantID: !merchantID.isBlank ? merchantID : nil,
                                                merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil,
                                                firstPaymentDate: firstPaymentDate.rawValue,
                                                numberOfPayments: numberOfPayments,
                                                period: period,
                                                standingOrderType: standingOrderType,
                                                allowFrpCustomerChanges: allowFrpCustomerChanges)
    }
}

struct FrPaymentCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        FrPaymentCreateMainSection(isValid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct FrPaymentCreateMainSectionModel {
    let amount: Decimal
    let reference: String
    let description: String?
    let redirectURL: String
    let bankID: String?
    let merchantID: String?
    let merchantUserID: String?
    let firstPaymentDate: String
    let numberOfPayments: Int
    let period: FrPaymentPeriod
    let standingOrderType: FrPaymentStandingOrderType?
    let allowFrpCustomerChanges: Bool?
}
