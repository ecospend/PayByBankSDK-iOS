//
//  PaymentGet.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentGet: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .id)) var id: String = ""
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
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
        .navigationTitle(L10n.paymentGetTitle.localizedKey)
        .safari(APIDocuments.Payment.get)
        .response($response)
    }
    
    func submit() {
        loading(true)
        PayByBank.payment.getPayment(request: PaymentGetRequest(id: id)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct PaymentGet_Previews: PreviewProvider {
    static var previews: some View {
        PaymentGet()
    }
}
