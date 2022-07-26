//
//  FrPaymentAPIs.swift
//  Example
//
//  Created by Yunus TÜR on 20.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct FrPaymentAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            Section {
                NavigationLink(L10n.frPaymentOpenTitle.localizedKey, destination: FrPaymentOpen())
                NavigationLink(L10n.frPaymentInitiateTitle.localizedKey, destination: FrPaymentInitiate())
            }
            Section {
                NavigationLink(L10n.frPaymentCreateTitle.localizedKey, destination: FrPaymentCreate())
                NavigationLink(L10n.frPaymentGetTitle.localizedKey, destination: FrPaymentGet())
                NavigationLink(L10n.frPaymentDeactivateTitle.localizedKey, destination: FrPaymentDeactivate())
            }
        }
        .navigationBarTitle(L10n.frPaymentTitle.localizedKey)
        .safari(APIDocuments.FrPayment.base)
    }
}

struct FrPaymentAPIs_Previews: PreviewProvider {
    static var previews: some View {
        FrPaymentAPIs()
    }
}
