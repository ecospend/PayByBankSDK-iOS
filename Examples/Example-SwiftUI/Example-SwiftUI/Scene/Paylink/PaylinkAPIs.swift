//
//  PaylinkAPIs.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct PaylinkAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            NavigationLink(L10n.paylinkOpenTitle.localizedKey, destination: PaylinkOpen())
            NavigationLink(L10n.paylinkInitiateTitle.localizedKey, destination: PaylinkInitiate())
            NavigationLink(L10n.paylinkCreateTitle.localizedKey, destination: PaylinkCreate())
            NavigationLink(L10n.paylinkGetTitle.localizedKey, destination: PaylinkGet())
            NavigationLink(L10n.paylinkDeactivateTitle.localizedKey, destination: PaylinkDeactivate())
        }
        .navigationBarTitle(L10n.paylinkTitle.localizedKey)
        .toolbar {
            Button {
                url = URL(string: APIDocuments.Paylink.base)
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

struct PaylinkAPIs_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkAPIs()
    }
}
