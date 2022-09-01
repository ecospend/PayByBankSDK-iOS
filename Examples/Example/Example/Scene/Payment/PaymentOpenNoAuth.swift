//
//  PaymentOpenNoAuth.swift
//  Example
//
//  Created by Yunus TÜR on 1.09.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentOpenNoAuth: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .id)) var id: String = ""
    @AppStorage(Self.storage(key: .url)) var url: String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $id)
                    .titled(L10n.inputID.localized.required)
                TextField("", text: $url)
                    .titled(L10n.inputURL.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(id.isBlank || !url.isURL)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paymentOpenNoAuthTitle.localizedKey)
        .safari(APIDocuments.Payment.get)
    }
    
    func submit() {
        hideKeyboard()
        guard let url = URL(string: url) else {
            return
        }
        loading(true)
        PayByBank.payment.open(id: id, url: url) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct PaymentOpenNoAuth_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOpenNoAuth()
    }
}
