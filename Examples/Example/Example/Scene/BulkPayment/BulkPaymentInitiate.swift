//
//  BulkPaymentInitiate.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentInitiate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: BulkPaymentCreateMainSectionModel? = nil
    
    @State private var isDebtorAccountValid: Bool = false
    @State private var debtorAccount: PayByBankAccountRequest? = nil
    
    @State private var isBulkPaymentOptionsValid: Bool = false
    @State private var bulkPaymentOptions: BulkPaymentOptions? = nil
    
    @State private var isBulkPaymentPaylinkOptionsValid: Bool = false
    @State private var bulkPaymentPaylinktOptions: BulkPaymentPaylinkOptions? = nil
    
    @State private var isNotificationOptionsValid: Bool = false
    @State private var notificationOptions: PayByBankNotificationOptionsRequest? = nil
    
    @State private var isBulkPaymentLimitOptionsValid: Bool = false
    @State private var bulkPaymentLimitOptions: BulkPaymentLimitOptions? = nil
    
    @State private var isBulkPaymentPaymentsValid: Bool = false
    @State private var bulkPaymentPayments: [BulkPaymentPaylinkEntry]? = nil
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                BulkPaymentCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                DebtorAccountSection(valid: $isDebtorAccountValid, value: $debtorAccount)
                BulkPaymentOptionsSection(valid: $isBulkPaymentOptionsValid, value: $bulkPaymentOptions)
                BulkPaymentPaylinkOptionsSection(valid: $isBulkPaymentPaylinkOptionsValid, value: $bulkPaymentPaylinktOptions)
                NotificationOptionsSection(valid: $isNotificationOptionsValid, value: $notificationOptions)
                BulkPaymentLimitOptionsSection(valid: $isBulkPaymentLimitOptionsValid, value: $bulkPaymentLimitOptions)
                BulkPaymentPaymentsSection(valid: $isBulkPaymentPaymentsValid, value: $bulkPaymentPayments)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isDebtorAccountValid ||
                      !isBulkPaymentOptionsValid ||
                      !isBulkPaymentPaylinkOptionsValid ||
                      !isNotificationOptionsValid ||
                      !isBulkPaymentLimitOptionsValid ||
                      !isBulkPaymentPaymentsValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.bulkPaymentInitiateTitle.localizedKey)
        .safari(APIDocuments.BulkPayment.create)
    }
    
    func submit() {
        hideKeyboard()
        guard let viewController = UIApplication.shared.topViewController else { return }
        guard let main = mainModel else { return }
        
        let request = BulkPaymentCreateRequest(bankID: main.bankID,
                                               debtorAccount: debtorAccount,
                                               description: main.description,
                                               fileReference: main.fileReference,
                                               reference: main.reference,
                                               redirectURL: main.redirectURL,
                                               merchantID: main.merchantID,
                                               merchantUserID: main.merchantUserID,
                                               paymentOptions: bulkPaymentOptions,
                                               options: bulkPaymentPaylinktOptions,
                                               notificationOptions: notificationOptions,
                                               limitOptions: bulkPaymentLimitOptions,
                                               payments: bulkPaymentPayments ?? [])
        
        loading(true)
        
        PayByBank.bulkPayment.initiate(request: request, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct BulkPaymentInitiate_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentInitiate()
    }
}
