//
//  PaymentOptionsSection.swift
//  Example-SwiftUI
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
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
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
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: getRefundInfo) { _ in validate() }
        .onChange(of: forPayout) { _ in validate() }
        .onChange(of: scheduledFor) { _ in validate() }
        .onChange(of: psuID) { _ in validate() }
        .onChange(of: paymentRails) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionPaymentOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return PaymentOption(getRefundInfo: getRefundInfo,
                                 forPayout: forPayout,
                                 scheduledFor: scheduledFor != .default ? scheduledFor.rawValue : nil,
                                 psuID: !psuID.isBlank ? psuID : nil,
                                 paymentRails: !paymentRails.isBlank ? paymentRails : nil)
        }()
    }
}

struct PaymentOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOptionsSection(isValid: .constant(true), value: .constant(nil))
    }
}
