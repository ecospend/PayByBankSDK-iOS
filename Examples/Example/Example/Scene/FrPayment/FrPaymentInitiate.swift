//
//  FrPaymentInitiate.swift
//  Example
//
//  Created by Yunus TÜR on 20.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct FrPaymentInitiate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: FrPaymentCreateMainSectionModel? = nil
    
    @State private var isCreditorAccountValid: Bool = false
    @State private var creditorAccount: PayByBankAccountRequest? = nil
    
    @State private var isDebtorAccountValid: Bool = false
    @State private var debtorAccount: PayByBankAccountRequest? = nil
    
    @State private var isFrPaymentOptionsValid: Bool = false
    @State private var frPaymentOptions: FrPaymentOptions? = nil
    
    @State private var isNotificationOptionsValid: Bool = false
    @State private var notificationOptions: PayByBankNotificationOptionsRequest? = nil
    
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                FrPaymentCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(isRequired: true, valid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(valid: $isDebtorAccountValid, value: $debtorAccount)
                FrPaymentOptionsSection(valid: $isFrPaymentOptionsValid, value: $frPaymentOptions)
                NotificationOptionsSection(valid: $isNotificationOptionsValid, value: $notificationOptions)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isCreditorAccountValid ||
                      !isDebtorAccountValid ||
                      !isFrPaymentOptionsValid ||
                      !isNotificationOptionsValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.frPaymentInitiateTitle.localizedKey)
        .safari(APIDocuments.FrPayment.create)
    }
    
    func submit() {
        guard let viewController = UIApplication.shared.topViewController else { return }
        guard let main = mainModel, let creditorAccount = creditorAccount else { return }
        
        let request = FrPaymentCreateRequest(redirectURL: main.redirectURL,
                                             amount: main.amount,
                                             reference: main.reference,
                                             description: main.description,
                                             bankID: main.bankID,
                                             merchantID: main.merchantID,
                                             merchantUserID: main.merchantUserID,
                                             creditorAccount: creditorAccount,
                                             debtorAccount: debtorAccount,
                                             firstPaymentDate: main.firstPaymentDate,
                                             numberOfPayments: main.numberOfPayments,
                                             period: main.period,
                                             standingOrderType: main.standingOrderType,
                                             frPaymentOptions: frPaymentOptions,
                                             allowFrpCustomerChanges: main.allowFrpCustomerChanges,
                                             notificationOptions: notificationOptions)
        
        loading(true)
        
        PayByBank.frPayment.initiate(request: request, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct FrPaymentInitiate_Previews: PreviewProvider {
    static var previews: some View {
        FrPaymentInitiate()
    }
}
