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
    @AppStorage(Self.storage(key: .paymentOptionsGetRefundInfo)) private var getRefundInfo: Bool = false
    @AppStorage(Self.storage(key: .optionsFirstPaymentAmount)) private var firstPaymentAmount: Decimal = 0.0
    @AppStorage(Self.storage(key: .optionsLastPaymentAmount)) private var lastPaymentAmount: Decimal = 0.0
    @AppStorage(Self.storage(key: .optionsAutoRedirect)) private var autoRedirect: Bool = false
    @AppStorage(Self.storage(key: .optionsGenerateQRCode)) private var generateQRCode: Bool = false
    @AppStorage(Self.storage(key: .optionsDisableQRCode)) private var disableQRCode: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: FrPaymentOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputPaymentOptionsGetRefundInfo.localized, isOn: $getRefundInfo)
                    TextField("", value: $firstPaymentAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputOptionsFirstPaymentAmount.localized)
                    TextField("", value: $lastPaymentAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputOptionsLastPaymentAmount.localized)
                    Toggle(L10n.inputOptionsAutoRedirect.localized, isOn: $autoRedirect)
                    Toggle(L10n.inputOptionsGenerateQRCode.localized, isOn: $generateQRCode)
                    Toggle(L10n.inputOptionsDisableQRCode.localized, isOn: $disableQRCode)
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
        valid = true
        
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
        FrPaymentOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
