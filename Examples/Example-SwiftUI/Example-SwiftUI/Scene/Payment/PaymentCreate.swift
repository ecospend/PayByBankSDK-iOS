//
//  PaymentCreate.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentCreate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: PaymentCreateMainSectionModel? = nil
    
    @State private var isCreditorAccountValid: Bool = false
    @State private var creditorAccount: PayByBankAccountRequest? = nil
    
    @State private var isDebtorAccountValid: Bool = false
    @State private var debtorAccount: PayByBankAccountRequest? = nil
    
    @State private var isPaymentOptionValid: Bool = false
    @State private var paymentOption: PaymentOption? = nil
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                PaymentCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(isRequired: true, valid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(valid: $isDebtorAccountValid, value: $debtorAccount)
                PaymentOptionsSection(valid: $isPaymentOptionValid, value: $paymentOption)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isCreditorAccountValid ||
                      !isDebtorAccountValid ||
                      !isPaymentOptionValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paymentCreateTitle.localizedKey)
        .safari(APIDocuments.Payment.create)
        .response($response)
    }
    
    func submit() {
        guard let main = mainModel, let creditorAccount = creditorAccount else { return }
        
        let request = PaymentCreateRequest(redirectURL: main.redirectURL,
                                           bankID: main.bankID,
                                           amount: main.amount,
                                           currency: main.currency,
                                           description: main.description,
                                           reference: main.reference,
                                           merchantID: main.merchantID,
                                           merchantUserID: main.merchantUserID,
                                           creditorAccount: creditorAccount,
                                           debtorAccount: debtorAccount,
                                           paymentOption: paymentOption,
                                           paymentType: main.paymentType)
        
        loading(true)
        
        PayByBank.payment.createPayment(request: request) { result in
            loading(false)
            response = result.string
        }
    }
}

struct PaymentCreate_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCreate()
    }
}
