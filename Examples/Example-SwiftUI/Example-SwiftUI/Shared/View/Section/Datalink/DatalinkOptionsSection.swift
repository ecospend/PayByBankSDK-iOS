//
//  DatalinkOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkOptionsSection: View {
    
    @AppStorage(Self.storage(key: .optionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .optionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsAllowMultipleConsent)) private var allowMultipleConsent: Bool = false
    @AppStorage(Self.storage(key: .optionsGenerateFinancialReport)) private var generateFinancialReport: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: DatalinkOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputOptionsAllowMultipleConsent.localized, isOn: $allowMultipleConsent)
                    Toggle(L10n.inputOptionsGenerateFinancialReport.localized, isOn: $generateFinancialReport)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: autoRedirect) { _ in validate() }
        .onChange(of: generateQRCode) { _ in validate() }
        .onChange(of: allowMultipleConsent) { _ in validate() }
        .onChange(of: generateFinancialReport) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionDatalinkOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return DatalinkOptions(autoRedirect: autoRedirect,
                                   generateQrCode: generateQRCode,
                                   allowMultipleConsent: allowMultipleConsent,
                                   generateFinancialReport: generateFinancialReport)
        }()
    }
}

struct DatalinkOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
