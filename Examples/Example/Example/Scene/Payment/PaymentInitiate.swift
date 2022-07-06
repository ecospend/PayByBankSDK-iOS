//
//  PaymentInitiate.swift
//  Example
//
//  Created by Yunus TÜR on 6.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentInitiate: View {
    
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
    
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                PaymentCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(required: true, valid: $isCreditorAccountValid, value: $creditorAccount)
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
        .navigationTitle(L10n.paymentInitiateTitle.localizedKey)
        .safari(APIDocuments.Payment.create)
    }
    
    func submit() {
        hideKeyboard()
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
        
        PayByBank.payment.initiate(request: request) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct PaymentInitiate_Previews: PreviewProvider {
    static var previews: some View {
        PaymentInitiate()
    }
}
