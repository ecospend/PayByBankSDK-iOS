//
//  DatalinkVerificationSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkVerificationSection: View {
    
    @AppStorage(Self.storage(key: .name)) private var name: String = ""
    @AppStorage(Self.storage(key: .phoneNumbers)) private var phoneNumbers: String = ""
    @AppStorage(Self.storage(key: .address)) private var address: String = ""
    @AppStorage(Self.storage(key: .email)) private var email: String = ""
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: VerificationParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    TextField("", text: $name)
                        .titled(L10n.inputName.localized)
                    TextField("", text: $phoneNumbers)
                        .keyboardType(.phonePad)
                        .titled(L10n.inputPhoneNumbers.localized)
                    TextField("", text: $address)
                        .titled(L10n.inputAddress.localized)
                    TextField("", text: $email)
                        .titled(L10n.inputEmail.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: name) { _ in validate() }
        .onChange(of: phoneNumbers) { _ in validate() }
        .onChange(of: address) { _ in validate() }
        .onChange(of: email) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionVerification.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return VerificationParameters(name: !name.isBlank ? name : nil,
                                          phoneNumbers: !phoneNumbers.isBlank ? [phoneNumbers] : nil,
                                          address: !address.isBlank ? address : nil,
                                          email: !email.isBlank ? email : nil)
        }()
    }
}

struct DatalinkVerificationSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkVerificationSection(valid: .constant(true), value: .constant(nil))
    }
}
