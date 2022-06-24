//
//  DatalinkCreate.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkCreate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: DatalinkCreateMainSectionModel? = nil
    
    @State private var isDatalinkOptionsValid: Bool = false
    @State private var datalinkOptions: DatalinkOptions? = nil
    
    @State private var isNotificationOptionsValid: Bool = false
    @State private var notificationOptions: PayByBankNotificationOptionsRequest? = nil
    
    @State private var isFinancialReportValid: Bool = false
    @State private var financialReport: FinancialReport? = nil
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                DatalinkCreateMainSection(valid: $isMainModelValid, value: $mainModel)
                DatalinkOptionsSection(valid: $isDatalinkOptionsValid, value: $datalinkOptions)
                NotificationOptionsSection(valid: $isNotificationOptionsValid, value: $notificationOptions)
                DatalinkFinancialReportSection(valid: $isFinancialReportValid, value: $financialReport)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isDatalinkOptionsValid ||
                      !isNotificationOptionsValid ||
                      !isFinancialReportValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.datalinkCreateTitle.localizedKey)
        .safari(APIDocuments.Datalink.create)
        .response($response)
    }
    
    func submit() {
        guard let main = mainModel else { return }
        
        let request = DatalinkCreateRequest(redirectURL: main.redirectURL,
                                            bankID: main.bankID,
                                            merchantID: main.merchantID,
                                            merchantUserID: main.merchantUserID,
                                            consentEndDate: main.consentEndDate,
                                            expiryDate: main.expiryDate,
                                            permissions: main.permissions,
                                            datalinkOptions: datalinkOptions,
                                            notificationOptions: notificationOptions,
                                            financialReport: financialReport)
        
        loading(true)
        
        PayByBank.datalink.createDatalink(request: request) { result in
            loading(false)
            response = result.string
        }
    }
}

struct DatalinkCreate_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkCreate()
    }
}
