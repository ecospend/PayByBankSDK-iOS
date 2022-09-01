//
//  DatalinkGetOfConsent.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkGetOfConsent: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .consentID)) var consentID: String = ""
    
    @State private var response: String? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $consentID)
                    .titled(L10n.inputConsentID.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(consentID.isBlank)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.datalinkGetOfConsentTitle.localizedKey)
        .safari(APIDocuments.Datalink.getOfConsent)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        loading(true)
        PayByBank.datalink.getDatalinkOfConsent(request: DatalinkGetConsentDatalinkRequest(consentID: consentID)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct DatalinkGetOfConsent_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkGetOfConsent()
    }
}
