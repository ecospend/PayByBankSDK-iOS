//
//  BulkPaymentPaylinkOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentPaylinkOptionsSection: View {
    
    @AppStorage(Self.storage(key: .optionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .optionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsDisableQRCode)) private var disableQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsPurpose)) private var purpose: String = ""
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: BulkPaymentPaylinkOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputOptionsDisableQRCode.localized, isOn: $disableQRCode)
                    TextField("", text: $purpose)
                        .titled(L10n.inputOptionsPurpose.localized)
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: autoRedirect) { _ in validate() }
        .onChange(of: generateQRCode) { _ in validate() }
        .onChange(of: disableQRCode) { _ in validate() }
        .onChange(of: purpose) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionPaylinkOptions.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return BulkPaymentPaylinkOptions(autoRedirect: autoRedirect,
                                             generateQrCode: generateQRCode,
                                             disableQrCode: disableQRCode,
                                             purpose: purpose)
        }()
    }
}

struct BulkPaymentPaylinkOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentPaylinkOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
