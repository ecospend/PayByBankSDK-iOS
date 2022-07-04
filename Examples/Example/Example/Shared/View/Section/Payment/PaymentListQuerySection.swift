//
//  PaymentListQuerySection.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentListQuerySection: View {
    
    @AppStorage(Self.storage(key: .merchantID)) private var merchantID: String = ""
    @AppStorage(Self.storage(key: .merchantUserID)) private var merchantUserID: String = ""
    @AppStorage(Self.storage(key: .startDate)) private var startDate: Date = .default
    @AppStorage(Self.storage(key: .endDate)) private var endDate: Date = .default
    @AppStorage(Self.storage(key: .paymentType)) private var paymentType: PaymentType = .auto
    @AppStorage(Self.storage(key: .page)) private var page: Int = 0
    
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaymentListRequest?
    
    var body: some View {
        List {
            Section {
                TextField("", text: $merchantID)
                    .titled(L10n.inputMerchantID.localized)
                TextField("", text: $merchantUserID)
                    .titled(L10n.inputMerchantUserID.localized)
                DatePicker(selection: $startDate, displayedComponents: .date) {
                    Text(L10n.inputStartDate.localized)
                }
                DatePicker(selection: $endDate, displayedComponents: .date) {
                    Text(L10n.inputEndDate.localized)
                }
                Menu(paymentType.rawValue) {
                    Button(PaymentType.auto.rawValue) { paymentType = .auto }
                    Button(PaymentType.domestic.rawValue) { paymentType = .domestic }
                    Button(PaymentType.domesticScheduled.rawValue) { paymentType = .domesticScheduled }
                    Button(PaymentType.international.rawValue) { paymentType = .international }
                    Button(PaymentType.internationalScheduled.rawValue) { paymentType = .internationalScheduled }
                }
                .titled(L10n.inputPaymentType.localized)
                TextField("", value: $page, format: .number)
                    .keyboardType(.numberPad)
                    .titled(L10n.inputPage.localized)
            }
        }
        .onChange(of: merchantID) { _ in validate() }
        .onChange(of: merchantUserID) { _ in validate() }
        .onChange(of: startDate) { _ in validate() }
        .onChange(of: endDate) { _ in validate() }
        .onChange(of: paymentType) { _ in validate() }
        .onChange(of: page) { _ in validate() }
        .onAppear { validate() }
    }
    
    func validate() {
        valid = true
        
        value = PaymentListRequest(merchantID: !merchantID.isBlank ? merchantID : nil,
                                   merchantUserID: !merchantUserID.isBlank ? merchantUserID : nil,
                                   startDate: startDate != .default ? startDate.rawValue : nil,
                                   endDate: endDate != .default ? endDate.rawValue : nil,
                                   paymentType: paymentType,
                                   page: page > 0 ? page : nil)
    }
}

struct PaymentListQuerySection_Previews: PreviewProvider {
    static var previews: some View {
        PaymentListQuerySection(valid: .constant(true), value: .constant(nil))
    }
}
