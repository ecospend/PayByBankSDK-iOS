//
//  PaylinkCreate.swift
//  Example-SwiftUI
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
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                PaylinkCreateMainSection(isValid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(isRequired: true, isValid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(isValid: $isDebtorAccountValid, value: $debtorAccount)
                PaylinkOptionsSection(isValid: $isPaylinkOptionsValid, value: $paylinkOptions)
                NotificationOptionsSection(isValid: $isNotificationOptionsValid, value: $notificationOptions)
                PaylinkPaymentOptionsSection(isValid: $isPaymentOptionsValid, value: $paymentOptions)
                PaylinkLimitOptionsSection(isValid: $isLimitOptionsValid, value: $limitOptions)
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
        .toolbar {
            Button {
                url = URL(string: APIDocuments.Paylink.create)
            } label: {
                Image(systemName: "safari")
            }
        }
        .sheet(item: $url) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
        .sheet(item: $response) { response in
            ResponseView(response: response)
        }
        
    }
    
    func submit() {
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
