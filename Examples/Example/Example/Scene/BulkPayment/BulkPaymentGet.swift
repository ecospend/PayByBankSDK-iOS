//
//  BulkPaymentGet.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentGet: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $uniqueID)
                    .titled(L10n.inputUniqueID.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(uniqueID.isBlank)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.bulkPaymentGetTitle.localizedKey)
        .safari(APIDocuments.BulkPayment.get)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        loading(true)
        PayByBank.bulkPayment.getBulkPayment(request: BulkPaymentGetRequest(uniqueID: uniqueID)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct BulkPaymentGet_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentGet()
    }
}
