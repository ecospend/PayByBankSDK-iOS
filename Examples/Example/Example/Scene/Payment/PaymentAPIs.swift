//
//  PaymentAPIs.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct PaymentAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            Section {
                NavigationLink(L10n.paymentCreateTitle.localizedKey, destination: PaymentCreate())
                NavigationLink(L10n.paymentListTitle.localizedKey, destination: PaymentList())
                NavigationLink(L10n.paymentGetTitle.localizedKey, destination: PaymentGet())
                NavigationLink(L10n.paymentCheckURLTitle.localizedKey, destination: PaymentCheckURL())
                NavigationLink(L10n.paymentCreateRefundTitle.localizedKey, destination: PaymentCreateRefund())
            }
        }
        .navigationBarTitle(L10n.paymentTitle.localizedKey)
        .safari(APIDocuments.Payment.base)
    }
}

struct PaymentAPIs_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAPIs()
    }
}
