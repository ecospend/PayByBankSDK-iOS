//
//  PaymentCheckURL.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentCheckURL: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .id)) var id: String = ""
    
    @State private var response: String? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $id)
                    .titled(L10n.inputID.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(id.isBlank)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paymentCheckURLTitle.localizedKey)
        .safari(APIDocuments.Payment.checkURL)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        loading(true)
        PayByBank.payment.checkPaymentURL(request: PaymentCheckURLRequest(id: id)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct PaymentCheckURL_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCheckURL()
    }
}
