//
//  PaylinkCreateMainSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .amount)) private var amount: Decimal = 0.0
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaylinkCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
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
        }
        .onChange(of: amount) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = {
            guard amount > 0, !reference.isBlank, redirectURL.isURL else { return false }
            return true
        }()
        
        value = PaylinkCreateMainSectionModel(amount: amount,
                                              reference: reference,
                                              description: !description.isBlank ? description : nil,
                                              redirectURL: redirectURL,
                                              bankID: !bankID.isBlank ? bankID : nil,
                                              merchantID: !merchantID.isBlank ? merchantID : nil,
                                              merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil)
    }
}

struct PaylinkCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkCreateMainSection(valid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct PaylinkCreateMainSectionModel {
    let amount: Decimal
    let reference: String
    let description: String?
    let redirectURL: String
    let bankID: String?
    let merchantID: String?
    let merchantUserID: String?
}
