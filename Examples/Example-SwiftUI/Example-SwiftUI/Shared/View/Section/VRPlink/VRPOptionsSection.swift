//
//  VRPOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPOptionsSection: View {
    
    @AppStorage(Self.storage(key: .paymentOptionsValidFrom)) var validFrom: Date = .default
    @AppStorage(Self.storage(key: .paymentOptionsValidTo)) var validTo: Date = .default
    @AppStorage(Self.storage(key: .paymentOptionsGetRefundInfo)) var getRefundInfo: Bool = true
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: VRPOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatePicker(selection: $validFrom, displayedComponents: .date) {
                        Text(L10n.inputPaymentOptionsValidFrom.localized)
                    }
                    DatePicker(selection: $validTo, displayedComponents: .date) {
                        Text(L10n.inputPaymentOptionsValidTo.localized)
                    }
                    Toggle(L10n.inputPaymentOptionsGetRefundInfo.localized, isOn: $getRefundInfo)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: validFrom) { _ in validate() }
        .onChange(of: validTo) { _ in validate() }
        .onChange(of: getRefundInfo) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionVRPOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return VRPOptions(validFrom: validFrom != .default ? validFrom.rawValue : nil,
                              validTo: validTo != .default ? validTo.rawValue : nil,
                              getRefundInfo: getRefundInfo)
        }()
    }
}

struct VRPOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        VRPOptionsSection(isValid: .constant(true), value: .constant(nil))
    }
}
