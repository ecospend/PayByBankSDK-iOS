//
//  PaymentOpen.swift
//  Example
//
//  Created by Yunus TÜR on 5.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentOpen: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .id)) var id: String = ""
    
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
        .navigationTitle(L10n.paymentOpenTitle.localizedKey)
        .safari(APIDocuments.Payment.get)
    }
    
    func submit() {
        hideKeyboard()
        loading(true)
        PayByBank.payment.open(id: id) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct PaymentOpen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOpen()
    }
}
