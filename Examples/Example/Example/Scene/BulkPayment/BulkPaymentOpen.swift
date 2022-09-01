//
//  BulkPaymentOpen.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentOpen: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    
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
        .navigationTitle(L10n.bulkPaymentOpenTitle.localizedKey)
        .safari(APIDocuments.BulkPayment.get)
    }
    
    func submit() {
        hideKeyboard()
        guard let viewController = UIApplication.shared.topViewController else { return }
        
        loading(true)
        PayByBank.bulkPayment.open(uniqueID: uniqueID, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct BulkPaymentOpen_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentOpen()
    }
}
