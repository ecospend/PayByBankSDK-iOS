//
//  VRPlinkAPIs.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct VRPlinkAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            NavigationLink(L10n.vrplinkOpenTitle.localizedKey, destination: VRPlinkOpen())
            NavigationLink(L10n.vrplinkInitiateTitle.localizedKey, destination: VRPlinkInitiate())
            NavigationLink(L10n.vrplinkCreateTitle.localizedKey, destination: VRPlinkCreate())
            NavigationLink(L10n.vrplinkGetTitle.localizedKey, destination: VRPlinkGet())
            NavigationLink(L10n.vrplinkDeactivateTitle.localizedKey, destination: VRPlinkDeactivate())
            NavigationLink(L10n.vrplinkListRecordsTitle.localizedKey, destination: VRPlinkListRecords())
        }
        .navigationBarTitle(L10n.vrplinkTitle.localizedKey)
        .toolbar {
            Button {
                url = URL(string: APIDocuments.VRPlink.base)
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

struct VRPlinkAPIs_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkAPIs()
    }
}
