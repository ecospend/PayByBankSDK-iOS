//
//  PaylinkOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkOptionsSection: View {
    
    @AppStorage(Self.storage(key: .paylinkOptionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .paylinkOptionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .paylinkOptionsAllowPartialPayments)) private var allowPartialPayments: Bool = false
    @AppStorage(Self.storage(key: .paylinkOptionsDisableQRCode)) private var disableQRCode: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: PaylinkOptions?
    
    var body: some View {
        Section(header: header) {
            Group {
                Toggle(L10n.inputPaylinkOptionsAutoRedirect.localized, isOn: $autoRedirect)
                Toggle(L10n.inputPaylinkOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                Toggle(L10n.inputPaylinkOptionsAllowPartialPayments.localized, isOn: $allowPartialPayments)
                Toggle(L10n.inputPaylinkOptionsDisableQRCode.localized, isOn: $disableQRCode)
            }
            .disabled(!isEnabled)
            .opacity(!isEnabled ? 0.5 : 1)
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
        isValid = true
        
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
        PaylinkOptionsSection(isValid: .constant(true), value: .constant(nil))
    }
}
