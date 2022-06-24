//
//  BulkPaymentOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentOptionsSection: View {
    
    @AppStorage(Self.storage(key: .paymentOptionsScheduledFor)) var scheduledFor: Date = .default
    @AppStorage(Self.storage(key: .paymentOptionsPaymentRails)) var paymentRails: String = ""
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: BulkPaymentOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatePicker(selection: $scheduledFor, displayedComponents: .date) {
                        Text(L10n.inputPaymentOptionsScheduledFor.localized)
                    }
                    TextField("", text: $paymentRails)
                        .titled(L10n.inputPaymentOptionsPaymentRails.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: scheduledFor) { _ in validate() }
        .onChange(of: paymentRails) { _ in validate() }
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
            return BulkPaymentOptions(scheduledFor: scheduledFor != .default ? scheduledFor.rawValue : nil,
                                      paymentRails: !paymentRails.isBlank ? paymentRails : nil)
        }()
    }
}

struct BulkPaymentOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
