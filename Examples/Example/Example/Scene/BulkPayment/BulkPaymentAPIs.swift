//
//  BulkPaymentAPIs.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct BulkPaymentAPIs: View {
    
    var body: some View {
        List {
            Section {
                NavigationLink(L10n.bulkPaymentOpenNoAuthTitle.localizedKey, destination: BulkPaymentOpenNoAuth())
                NavigationLink(L10n.bulkPaymentOpenTitle.localizedKey, destination: BulkPaymentOpen())
                NavigationLink(L10n.bulkPaymentInitiateTitle.localizedKey, destination: BulkPaymentInitiate())
            }
            Section {
                NavigationLink(L10n.bulkPaymentCreateTitle.localizedKey, destination: BulkPaymentCreate())
                NavigationLink(L10n.bulkPaymentGetTitle.localizedKey, destination: BulkPaymentGet())
                NavigationLink(L10n.bulkPaymentDeactivateTitle.localizedKey, destination: BulkPaymentDeactivate())
            }
        }
        .navigationBarTitle(L10n.bulkPaymentTitle.localizedKey)
        .safari(APIDocuments.BulkPayment.base)
    }
}

struct BulkPaymentAPIs_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentAPIs()
    }
}
