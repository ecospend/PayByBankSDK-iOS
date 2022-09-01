//
//  PaylinkCreate.swift
//  Example
//
//  Created by Yunus TÜR on 20.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkCreate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: PaylinkCreateMainSectionModel? = nil
    
    @State private var isCreditorAccountValid: Bool = false
    @State private var creditorAccount: PayByBankAccountRequest? = nil
    
    @State private var isDebtorAccountValid: Bool = false
    @State private var debtorAccount: PayByBankAccountRequest? = nil
    
    @State private var isPaylinkOptionsValid: Bool = false
    @State private var paylinkOptions: PaylinkOptions? = nil
    
    @State private var isNotificationOptionsValid: Bool = false
    @State private var notificationOptions: PayByBankNotificationOptionsRequest? = nil
    
    @State private var isPaymentOptionsValid: Bool = false
    @State private var paymentOptions: PaylinkPaymentOptions? = nil
    
    @State private var isLimitOptionsValid: Bool = false
    @State private var limitOptions: PaylinkLimitOptions? = nil
    
    @State private var response: String? = nil
    
    var body: some View {
        VStack {
            Form {
                PaylinkCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(required: true, valid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(valid: $isDebtorAccountValid, value: $debtorAccount)
                PaylinkOptionsSection(valid: $isPaylinkOptionsValid, value: $paylinkOptions)
                NotificationOptionsSection(valid: $isNotificationOptionsValid, value: $notificationOptions)
                PaylinkPaymentOptionsSection(valid: $isPaymentOptionsValid, value: $paymentOptions)
                PaylinkLimitOptionsSection(valid: $isLimitOptionsValid, value: $limitOptions)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isCreditorAccountValid ||
                      !isDebtorAccountValid ||
                      !isPaylinkOptionsValid ||
                      !isNotificationOptionsValid ||
                      !isPaymentOptionsValid ||
                      !isLimitOptionsValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paylinkCreateTitle.localizedKey)
        .safari(APIDocuments.Paylink.create)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        guard let main = mainModel, let creditorAccount = creditorAccount else { return }
        
        let request = PaylinkCreateRequest(redirectURL: main.redirectURL,
                                           amount: main.amount,
                                           reference: main.reference,
                                           description: main.description,
                                           bankID: main.bankID,
                                           merchantID: main.merchantID,
                                           merchantUserID: main.merchantUserID,
                                           creditorAccount: creditorAccount,
                                           debtorAccount: debtorAccount,
                                           paylinkOptions: paylinkOptions,
                                           notificationOptions: notificationOptions,
                                           paymentOptions: paymentOptions,
                                           limitOptions: limitOptions)
        
        loading(true)
        
        PayByBank.paylink.createPaylink(request: request) { result in
            loading(false)
            response = result.string
        }
    }
}

struct PaylinkCreate_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkCreate()
    }
}
