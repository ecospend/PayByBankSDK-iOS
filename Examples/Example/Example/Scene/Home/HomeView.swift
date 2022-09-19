//
//  HomeView.swift
//  Example
//
//  Created by Yunus TÜR on 10.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(L10n.paylinkOpenTitle.localizedKey, destination: PaylinkOpen())
                NavigationLink(L10n.frPaymentOpenTitle.localizedKey, destination: FrPaymentOpen())
                NavigationLink(L10n.bulkPaymentOpenTitle.localizedKey, destination: BulkPaymentOpen())
                NavigationLink(L10n.vrplinkOpenTitle.localizedKey, destination: VRPlinkOpen())
                NavigationLink(L10n.datalinkOpenTitle.localizedKey, destination: DatalinkOpen())
                NavigationLink(L10n.paymentOpenTitle.localizedKey, destination: PaymentOpen())
            }
            .navigationBarTitle(L10n.homeTitle.localizedKey)
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
