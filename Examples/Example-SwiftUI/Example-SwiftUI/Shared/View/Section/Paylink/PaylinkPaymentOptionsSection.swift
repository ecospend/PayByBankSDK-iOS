//
//  PaylinkPaymentOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 16.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkPaymentOptionsSection: View {
    
    @AppStorage(Self.storage(key: .paymentOptionsPaymentRails)) var paymentRails: String = ""
    @AppStorage(Self.storage(key: .paymentOptionsGetRefundInfo)) var getRefundInfo: Bool = true
    @AppStorage(Self.storage(key: .paymentOptionsForPayout)) var forPayout: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaylinkPaymentOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    TextField("", text: $paymentRails)
                        .titled(L10n.inputPaymentOptionsPaymentRails.localized)
                    Toggle(L10n.inputPaymentOptionsGetRefundInfo.localized, isOn: $getRefundInfo)
                    Toggle(L10n.inputPaymentOptionsForPayout.localized, isOn: $forPayout)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: paymentRails) { _ in validate() }
        .onChange(of: getRefundInfo) { _ in validate() }
        .onChange(of: forPayout) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionPaymentOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard isEnabled else { return nil }
            return PaylinkPaymentOptions(paymentRails: !paymentRails.isBlank ? paymentRails : nil,
                                         getRefundInfo: getRefundInfo,
                                         forPayout: forPayout)
        }()
    }
}

struct PaylinkPaymentOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkPaymentOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
