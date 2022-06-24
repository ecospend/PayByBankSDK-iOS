//
//  PaymentList.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentList: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isQueryValid: Bool = false
    @State private var query: PaymentListRequest? = nil
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                PaymentListQuerySection(isValid: $isQueryValid, value: $query)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isQueryValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paymentListTitle.localizedKey)
        .safari(APIDocuments.Payment.list)
        .response($response)
    }
    
    func submit() {
        guard let request = query else { return }
        
        loading(true)
        
        PayByBank.payment.listPayments(request: request) { result in
            loading(false)
            response = result.string
        }
    }
}

struct PaymentList_Previews: PreviewProvider {
    static var previews: some View {
        PaymentList()
    }
}
