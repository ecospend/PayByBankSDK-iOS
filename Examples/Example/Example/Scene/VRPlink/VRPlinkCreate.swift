//
//  VRPlinkCreate.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkCreate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: VRPlinkCreateMainSectionModel? = nil
    
    @State private var isCreditorAccountValid: Bool = false
    @State private var creditorAccount: PayByBankAccountRequest? = nil
    
    @State private var isDebtorAccountValid: Bool = false
    @State private var debtorAccount: PayByBankAccountRequest? = nil
    
    @State private var isVRPOptionsValid: Bool = false
    @State private var vrpOptions: VRPOptions? = nil
    
    @State private var isVRPLimitOptionsValid: Bool = false
    @State private var vrpLimitOptions: VRPLimitOptions? = nil
    
    @State private var isNotificationOptionsValid: Bool = false
    @State private var notificationOptions: PayByBankNotificationOptionsRequest? = nil
    
    @State private var isVRPlinkOptionsValid: Bool = false
    @State private var vrplinkOptions: VRPlinkOptions? = nil
    
    @State private var isVRPlinkLimitOptionsValid: Bool = false
    @State private var vrplinkLimitOptions: VRPlinkLimitOptions? = nil
    
    @State private var response: String? = nil
    
    var body: some View {
        VStack {
            Form {
                VRPlinkCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(valid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(valid: $isDebtorAccountValid, value: $debtorAccount)
                VRPOptionsSection(valid: $isVRPOptionsValid, value: $vrpOptions)
                VRPLimitOptionsSection(valid: $isVRPLimitOptionsValid, value: $vrpLimitOptions)
                NotificationOptionsSection(valid: $isNotificationOptionsValid, value: $notificationOptions)
                VRPlinkOptionsSection(valid: $isVRPlinkOptionsValid, value: $vrplinkOptions)
                VRPlinkLimitOptionsSection(valid: $isVRPlinkLimitOptionsValid, value: $vrplinkLimitOptions)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isCreditorAccountValid ||
                      !isDebtorAccountValid ||
                      !isVRPOptionsValid ||
                      !isVRPLimitOptionsValid ||
                      !isNotificationOptionsValid ||
                      !isVRPlinkOptionsValid ||
                      !isVRPlinkLimitOptionsValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.vrplinkCreateTitle.localizedKey)
        .safari(APIDocuments.VRPlink.create)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        guard let main = mainModel else { return }
        
        let request = VRPlinkCreateRequest(redirectURL: main.redirectURL,
                                           bankID: main.bankID,
                                           reason: main.reason,
                                           type: main.type,
                                           verifyCreditorAccount: main.verifyCreditorAccount,
                                           verifyDebtorAccount: main.verifyDebtorAccount,
                                           merchantID: main.merchantID,
                                           merchantUserID: main.merchantUserID,
                                           reference: main.reference,
                                           description: main.description,
                                           creditorAccount: creditorAccount,
                                           debtorAccount: debtorAccount,
                                           vrpOptions: vrpOptions,
                                           limitOptions: vrpLimitOptions,
                                           notificationOptions: notificationOptions,
                                           vrplinkOptions: vrplinkOptions,
                                           vrplinkLimitOptions: vrplinkLimitOptions)
        
        loading(true)
        
        PayByBank.vrplink.createVRPlink(request: request) { result in
            loading(false)
            response = result.string
        }
    }
}

struct VRPlinkCreate_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkCreate()
    }
}
