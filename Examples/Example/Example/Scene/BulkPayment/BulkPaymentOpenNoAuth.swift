//
//  BulkPaymentOpenNoAuth.swift
//  Example
//
//  Created by Yunus TÜR on 1.09.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentOpenNoAuth: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    @AppStorage(Self.storage(key: .url)) var url: String = ""
    @AppStorage(Self.storage(key: .redirectURL)) var redirectURL: String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $uniqueID)
                    .titled(L10n.inputUniqueID.localized.required)
                TextField("", text: $url)
                    .titled(L10n.inputURL.localized.required)
                TextField("", text: $redirectURL)
                    .titled(L10n.inputRedirectURL.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(uniqueID.isBlank || !url.isURL || !redirectURL.isURL)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.bulkPaymentOpenNoAuthTitle.localizedKey)
        .safari(APIDocuments.BulkPayment.get)
    }
    
    func submit() {
        hideKeyboard()
        guard let url = URL(string: url),
              let redirectURL = URL(string: redirectURL),
              let viewController = UIApplication.shared.topViewController else {
            return
        }
        loading(true)
        PayByBank.bulkPayment.open(uniqueID: uniqueID, url: url, redirectURL: redirectURL, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct BulkPaymentOpenNoAuth_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentOpenNoAuth()
    }
}
