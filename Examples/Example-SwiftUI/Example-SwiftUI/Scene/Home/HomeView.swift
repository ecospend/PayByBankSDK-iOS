//
//  HomeView.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 10.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(L10n.paylinkTitle.localizedKey, destination: PaylinkAPIs())
                NavigationLink(L10n.frPaymentTitle.localizedKey, destination: FrPaymentAPIs())
                NavigationLink(L10n.bulkPaymentTitle.localizedKey, destination: BulkPaymentAPIs())
                NavigationLink(L10n.vrplinkTitle.localizedKey, destination: VRPlinkAPIs())
                NavigationLink(L10n.datalinkTitle.localizedKey, destination: DatalinkAPIs())
                NavigationLink(L10n.paymentTitle.localizedKey, destination: PaymentAPIs())
            }
            .navigationBarTitle(L10n.homeTitle.localizedKey)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        Settings()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
