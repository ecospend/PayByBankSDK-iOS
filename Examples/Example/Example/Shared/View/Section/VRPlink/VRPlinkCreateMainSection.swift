//
//  VRPlinkCreateMainSection.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .reason)) private var reason: VRPReason = .none
    @AppStorage(Self.storage(key: .type)) private var type: VRPType = .sweeping
    @AppStorage(Self.storage(key: .verifyCreditorAccount)) private var verifyCreditorAccount: Bool = false
    @AppStorage(Self.storage(key: .verifyDebtorAccount)) private var verifyDebtorAccount: Bool = false
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: VRPlinkCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
                TextField("", text: $bankID)
                    .titled(L10n.inputBankID.localized)
                Menu(reason.rawValue) {
                    Button(VRPReason.none.rawValue) { reason = .none }
                    Button(VRPReason.partyToParty.rawValue) { reason = .partyToParty }
                    Button(VRPReason.billPayment.rawValue) { reason = .billPayment }
                    Button(VRPReason.ecommerceGoods.rawValue) { reason = .ecommerceGoods }
                    Button(VRPReason.ecommerceServices.rawValue) { reason = .ecommerceServices }
                    Button(VRPReason.other.rawValue) { reason = .other }
                }
                .titled(L10n.inputReason.localized.required)
                Menu(type.rawValue) {
                    Button(VRPType.sweeping.rawValue) { type = .sweeping }
                    Button(VRPType.vrp.rawValue) { type = .vrp }
                }
                .titled(L10n.inputType.localized)
                Toggle(L10n.inputVerifyCreditorAccount.localized, isOn: $verifyCreditorAccount)
                Toggle(L10n.inputVerifyDebtorAccount.localized, isOn: $verifyDebtorAccount)
                TextField("", text: $merchantID)
                    .titled(L10n.inputMerchantID.localized)
                TextField("", text: $merchantUserID)
                    .titled(L10n.inputMerchantUserID.localized)
                TextField("", text: $reference)
                    .titled(L10n.inputReference.localized.required)
                TextField("", text: $description)
                    .titled(L10n.inputDescription.localized.required)
            }
        }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: reason) { _ in validate() }
        .onChange(of: type) { _ in validate() }
        .onChange(of: verifyCreditorAccount) { _ in validate() }
        .onChange(of: verifyDebtorAccount) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = {
            guard reason != .none, !reference.isBlank, !description.isBlank, redirectURL.isURL else { return false }
            return true
        }()
        
        value = VRPlinkCreateMainSectionModel(redirectURL: redirectURL,
                                              bankID: bankID,
                                              reason: reason,
                                              type: type,
                                              verifyCreditorAccount: verifyCreditorAccount,
                                              verifyDebtorAccount: verifyDebtorAccount,
                                              merchantID: merchantID,
                                              merchantUserID: merchantUserID,
                                              reference: reference,
                                              description: description)
    }
}

struct VRPlinkCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkCreateMainSection(valid: .constant(true), value: .constant(nil))
    }
}

struct VRPlinkCreateMainSectionModel {
    let redirectURL: String
    let bankID: String?
    let reason: VRPReason
    let type: VRPType?
    let verifyCreditorAccount: Bool?
    let verifyDebtorAccount: Bool?
    let merchantID: String?
    let merchantUserID: String?
    let reference: String
    let description: String
}
