//
//  BulkPaymentAPIs.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct BulkPaymentAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            NavigationLink(L10n.bulkPaymentOpenTitle.localizedKey, destination: BulkPaymentOpen())
            NavigationLink(L10n.bulkPaymentInitiateTitle.localizedKey, destination: BulkPaymentInitiate())
            NavigationLink(L10n.bulkPaymentCreateTitle.localizedKey, destination: BulkPaymentCreate())
            NavigationLink(L10n.bulkPaymentGetTitle.localizedKey, destination: BulkPaymentGet())
            NavigationLink(L10n.bulkPaymentDeactivateTitle.localizedKey, destination: BulkPaymentDeactivate())
        }
        .navigationBarTitle(L10n.bulkPaymentTitle.localizedKey)
        .toolbar {
            Button {
                url = URL(string: APIDocuments.BulkPayment.base)
            } label: {
                Image(systemName: "safari")
            }
        }
        .sheet(item: $url) { url in
            SafariView(url: url)
                .ignoresSafeArea()
        }
    }
}

struct BulkPaymentAPIs_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentAPIs()
    }
}
