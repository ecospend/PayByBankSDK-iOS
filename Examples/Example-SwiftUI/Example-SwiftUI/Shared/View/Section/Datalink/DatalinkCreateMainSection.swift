//
//  DatalinkCreateMainSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    @AppStorage(Self.storage(key: .consentEndDate)) private var consentEndDate: Date = .now
    @AppStorage(Self.storage(key: .expiryDate)) private var expiryDate: Date = .now
    @AppStorage(Self.storage(key: .permissions)) private var permissions: ConsentPermission = .account
    
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: DatalinkCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
                TextField("", text: $bankID)
                    .titled(L10n.inputBankID.localized)
                TextField("", text: $merchantID)
                    .titled(L10n.inputMerchantID.localized)
                TextField("", text: $merchantUserID)
                    .titled(L10n.inputMerchantUserID.localized)
                DatePicker(selection: $consentEndDate, displayedComponents: .date) {
                    Text(L10n.inputConsentEndDate.localized.required)
                }
                DatePicker(selection: $expiryDate, displayedComponents: .date) {
                    Text(L10n.inputExpiryDate.localized)
                }
                Menu(permissions.rawValue) {
                    Button(ConsentPermission.account.rawValue) { permissions = .account }
                    Button(ConsentPermission.balance.rawValue) { permissions = .balance }
                    Button(ConsentPermission.trasactions.rawValue) { permissions = .trasactions }
                    Button(ConsentPermission.directDebits.rawValue) { permissions = .directDebits }
                    Button(ConsentPermission.standingOrders.rawValue) { permissions = .standingOrders }
                    Button(ConsentPermission.parties.rawValue) { permissions = .parties }
                    Button(ConsentPermission.scheduledPayments.rawValue) { permissions = .scheduledPayments }
                    Button(ConsentPermission.statements.rawValue) { permissions = .statements }
                    Button(ConsentPermission.offers.rawValue) { permissions = .offers }
                }
                .titled(L10n.inputPermissions.localized)
            }
        }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onChange(of: consentEndDate) { _ in validate() }
        .onChange(of: expiryDate) { _ in validate() }
        .onChange(of: permissions) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        isValid = {
            guard redirectURL.isURL, consentEndDate > .now else { return false }
            return true
        }()
        
        value = DatalinkCreateMainSectionModel(redirectURL: redirectURL,
                                               bankID: !bankID.isBlank ? bankID : nil,
                                               merchantID: !merchantID.isBlank ? merchantID : nil,
                                               merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil,
                                               consentEndDate: consentEndDate.rawValue,
                                               expiryDate: expiryDate > .now ? expiryDate.rawValue : nil,
                                               permissions: [permissions])
    }
}

struct DatalinkCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkCreateMainSection(isValid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct DatalinkCreateMainSectionModel {
    let redirectURL: String
    let bankID: String?
    let merchantID: String?
    let merchantUserID: String?
    let consentEndDate: String
    let expiryDate: String?
    let permissions: [ConsentPermission]?
}
