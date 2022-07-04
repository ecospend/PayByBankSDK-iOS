//
//  VRPlinkOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkOptionsSection: View {
    
    @AppStorage(Self.storage(key: .optionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsDisableQRCode)) private var disableQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .optionsDontRedirect)) private var dontRedirect: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: VRPlinkOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputOptionsDisableQRCode.localized, isOn: $disableQRCode)
                    Toggle(L10n.inputOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputOptionsDontRedirect.localized, isOn: $dontRedirect)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: generateQRCode) { _ in validate() }
        .onChange(of: disableQRCode) { _ in validate() }
        .onChange(of: autoRedirect) { _ in validate() }
        .onChange(of: dontRedirect) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionVRPlinkOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return VRPlinkOptions(generateQrCode: generateQRCode,
                                  disableQrCode: disableQRCode,
                                  autoRedirect: autoRedirect,
                                  dontRedirect: dontRedirect)
        }()
    }
}

struct VRPlinkOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
