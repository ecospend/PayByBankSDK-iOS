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
