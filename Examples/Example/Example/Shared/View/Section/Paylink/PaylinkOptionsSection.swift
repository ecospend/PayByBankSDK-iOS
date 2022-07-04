//
//  PaylinkOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkOptionsSection: View {
    
    @AppStorage(Self.storage(key: .optionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .optionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsAllowPartialPayments)) private var allowPartialPayments: Bool = false
    @AppStorage(Self.storage(key: .optionsDisableQRCode)) private var disableQRCode: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaylinkOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputOptionsAllowPartialPayments.localized, isOn: $allowPartialPayments)
                    Toggle(L10n.inputOptionsDisableQRCode.localized, isOn: $disableQRCode)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: autoRedirect) { _ in validate() }
        .onChange(of: generateQRCode) { _ in validate() }
        .onChange(of: allowPartialPayments) { _ in validate() }
        .onChange(of: disableQRCode) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionPaylinkOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return PaylinkOptions(autoRedirect: autoRedirect,
                                  generateQrCode: generateQRCode,
                                  allowPartialPayments: allowPartialPayments,
                                  disableQrCode: disableQRCode,
                                  tip: nil)
        }()
    }
}

struct PaylinkOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
