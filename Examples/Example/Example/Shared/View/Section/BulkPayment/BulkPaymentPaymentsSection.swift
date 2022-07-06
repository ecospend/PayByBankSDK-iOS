//
//  BulkPaymentPaymentsSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentPaymentsSection: View {
    
    @AppStorage(Self.storage(key: .amount)) private var amount: Decimal = 0.0
    @AppStorage(Self.storage(key: .reference)) private var reference: String = ""
    @AppStorage(Self.storage(key: .paymentOptionsScheduledFor)) private var scheduledFor: Date = .default
    @AppStorage(Self.storage(key: .paymentOptionsClientReferenceID)) private var clientReferenceID: String = ""
    
    @State private var isCreditorAccountValid: Bool = false
    @State private var creditorAccount: PayByBankAccountRequest? = nil
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: [BulkPaymentPaylinkEntry]?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    CreditorAccountSection(required: true, valid: $isCreditorAccountValid, value: $creditorAccount)
                    TextField("", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputAmount.localized.required)
                    TextField("", text: $reference)
                        .titled(L10n.inputReference.localized.required)
                    DatePicker(selection: $scheduledFor, displayedComponents: .date) {
                        Text(L10n.inputPaymentOptionsScheduledFor.localized)
                    }
                    TextField("", text: $clientReferenceID)
                        .titled(L10n.inputPaymentOptionsClientReferenceID.localized)
                }
            }
        }
        .onChange(of: isCreditorAccountValid) { _ in validate() }
        .onChange(of: amount) { _ in validate() }
        .onChange(of: reference) { _ in validate() }
        .onChange(of: scheduledFor) { _ in validate() }
        .onChange(of: clientReferenceID) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Text(L10n.sectionPayments.localized)
    }
    
    func validate() {
        valid = {
            guard isCreditorAccountValid ,amount > 0, !reference.isBlank else { return false }
            return true
        }()
        
        value = {
            guard let creditorAccount = creditorAccount else { return nil }
            return [
                BulkPaymentPaylinkEntry(creditorAccount: creditorAccount,
                                        amount: amount,
                                        reference: reference,
                                        scheduledFor: scheduledFor != .default ? scheduledFor.rawValue : nil,
                                        clientReferenceID: clientReferenceID.isBlank ? clientReferenceID : nil)
            ]
        }()
    }
}

struct BulkPaymentPaymentsSection_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentPaymentsSection(valid: .constant(true), value: .constant(nil))
    }
}
