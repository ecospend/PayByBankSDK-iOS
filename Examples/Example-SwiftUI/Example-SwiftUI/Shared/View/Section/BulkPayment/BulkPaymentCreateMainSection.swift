//
//  BulkPaymentCreateMainSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct BulkPaymentCreateMainSection: View {
    
    @AppStorage(Self.storage(key: .bankID)) private var bankID: String = ""
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .description)) private var description: String = ""
    @AppStorage(Self.storage(key: .fileReference)) private var fileReference: String = ""
    @AppStorage(Self.storage(key: .redirectURL)) private var redirectURL: String = ""
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: BulkPaymentCreateMainSectionModel?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $bankID)
                    .titled(L10n.inputBankID.localized)
                TextField("", text: $reference)
                    .titled(L10n.inputReference.localized)
                TextField("", text: $description)
                    .titled(L10n.inputDescription.localized)
                TextField("", text: $fileReference)
                    .titled(L10n.inputFileReference.localized.required)
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
                TextField("", text: $merchantID)
                    .titled(L10n.inputMerchantID.localized)
                TextField("", text: $merchantUserID)
                    .titled(L10n.inputMerchantUserID.localized)
            }
        }
        .onChange(of: bankID) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: description) { _ in validate() }
        .onChange(of: fileReference) { _ in validate() }
        .onChange(of: redirectURL) { _ in validate() }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = {
            guard !fileReference.isBlank, redirectURL.isURL else { return false }
            return true
        }()
        
        value = BulkPaymentCreateMainSectionModel(bankID: !bankID.isBlank ? bankID : nil,
                                                  reference: !reference.isBlank ? reference : nil,
                                                  description: !description.isBlank ? description : nil,
                                                  fileReference: fileReference,
                                                  redirectURL: redirectURL,
                                                  merchantID: !merchantID.isBlank ? merchantID : nil,
                                                  merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil)
    }
}

struct BulkPaymentCreateMainSection_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentCreateMainSection(valid: .constant(true), value: .constant(nil))
    }
}

// MARK: - Model
struct BulkPaymentCreateMainSectionModel {
    let bankID: String?
    let reference: String?
    let description: String?
    let fileReference: String
    let redirectURL: String
    let merchantID: String?
    let merchantUserID: String?
}
