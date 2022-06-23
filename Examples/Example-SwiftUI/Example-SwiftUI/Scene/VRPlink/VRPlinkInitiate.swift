//
//  VRPlinkInitiate.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkInitiate: View {
    
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
    
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                VRPlinkCreateMainSection(isValid: $isMainModelValid, value: $mainModel)
                CreditorAccountSection(isValid: $isCreditorAccountValid, value: $creditorAccount)
                DebtorAccountSection(isValid: $isDebtorAccountValid, value: $debtorAccount)
                VRPOptionsSection(isValid: $isVRPOptionsValid, value: $vrpOptions)
                VRPLimitOptionsSection(isValid: $isVRPLimitOptionsValid, value: $vrpLimitOptions)
                NotificationOptionsSection(isValid: $isNotificationOptionsValid, value: $notificationOptions)
                VRPlinkOptionsSection(isValid: $isVRPlinkOptionsValid, value: $vrplinkOptions)
                VRPlinkLimitOptionsSection(isValid: $isVRPlinkLimitOptionsValid, value: $vrplinkLimitOptions)
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
        .navigationTitle(L10n.vrplinkInitiateTitle.localizedKey)
        .toolbar {
            Button {
                url = URL(string: APIDocuments.VRPlink.create)
            } label: {
                Image(systemName: "safari")
            }
        }
        .sheet(item: $url) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
    }
    
    func submit() {
        guard let viewController = UIApplication.shared.topViewController else { return }
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
        
        PayByBank.vrplink.initiate(request: request, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct VRPlinkInitiate_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkInitiate()
    }
}
