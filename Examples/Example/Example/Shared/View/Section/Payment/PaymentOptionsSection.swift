//
//  PaymentOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentOptionsSection: View {
    
    @AppStorage(Self.storage(key: .paymentOptionsGetRefundInfo)) var getRefundInfo: Bool = true
    @AppStorage(Self.storage(key: .paymentOptionsForPayout)) var forPayout: Bool = false
    @AppStorage(Self.storage(key: .paymentOptionsScheduledFor)) var scheduledFor: Date = .default
    @AppStorage(Self.storage(key: .paymentOptionsPsuID)) var psuID: String = ""
    @AppStorage(Self.storage(key: .paymentOptionsPaymentRails)) var paymentRails: String = ""
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaymentOption?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputPaymentOptionsGetRefundInfo.localized, isOn: $getRefundInfo)
                    Toggle(L10n.inputPaymentOptionsForPayout.localized, isOn: $forPayout)
                    DatePicker(selection: $scheduledFor, displayedComponents: .date) {
                        Text(L10n.inputPaymentOptionsScheduledFor.localized)
                    }
                    TextField("", text: $psuID)
                        .titled(L10n.inputPaymentOptionsPsuID.localized)
                    TextField("", text: $paymentRails)
                        .titled(L10n.inputPaymentOptionsPaymentRails.localized)
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: getRefundInfo) { _ in validate() }
        .onChange(of: forPayout) { _ in validate() }
        .onChange(of: scheduledFor) { _ in validate() }
        .onChange(of: psuID) { _ in validate() }
        .onChange(of: paymentRails) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionPaymentOptions.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return PaymentOption(getRefundInfo: getRefundInfo,
                                 forPayout: forPayout,
                                 scheduledFor: scheduledFor != .default ? scheduledFor : nil,
                                 psuID: !psuID.isBlank ? psuID : nil,
                                 paymentRails: !paymentRails.isBlank ? paymentRails : nil)
        }()
    }
}

struct PaymentOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
