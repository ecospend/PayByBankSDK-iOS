//
//  FrPaymentOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 20.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct FrPaymentOptionsSection: View {
    @AppStorage(Self.storage(key: .frPaymentOptionsGetRefundInfo)) private var getRefundInfo: Bool = false
    @AppStorage(Self.storage(key: .frPaymentOptionsFirstPaymentAmount)) private var firstPaymentAmount: Decimal = 0.0
    @AppStorage(Self.storage(key: .frPaymentOptionsLastPaymentAmount)) private var lastPaymentAmount: Decimal = 0.0
    @AppStorage(Self.storage(key: .frPaymentOptionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .frPaymentOptionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .frPaymentOptionsDisableQRCode)) private var disableQRCode: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: FrPaymentOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputFrPaymentOptionsGetRefundInfo.localized, isOn: $getRefundInfo)
                    TextField("", value: $firstPaymentAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputFrPaymentOptionsFirstPaymentAmount.localized)
                    TextField("", value: $lastPaymentAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputFrPaymentOptionsLastPaymentAmount.localized)
                    Toggle(L10n.inputPaylinkOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputPaylinkOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputPaylinkOptionsDisableQRCode.localized, isOn: $disableQRCode)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: getRefundInfo) { _ in validate() }
        .onChange(of: firstPaymentAmount) { _ in validate() }
        .onChange(of: lastPaymentAmount) { _ in validate() }
        .onChange(of: autoRedirect) { _ in validate() }
        .onChange(of: generateQRCode) { _ in validate() }
        .onChange(of: disableQRCode) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionFrPaymentOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return FrPaymentOptions(getRefundInfo: getRefundInfo,
                                    firstPaymentAmount: firstPaymentAmount > 0 ? firstPaymentAmount : nil,
                                    lastPaymentAmount: lastPaymentAmount > 0 ? lastPaymentAmount : nil,
                                    autoRedirect: autoRedirect,
                                    generateQrCode: generateQRCode,
                                    disableQrCode: disableQRCode,
                                    editableFields: nil)
        }()
    }
}

struct FrPaymentOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        FrPaymentOptionsSection(isValid: .constant(true), value: .constant(nil))
    }
}
