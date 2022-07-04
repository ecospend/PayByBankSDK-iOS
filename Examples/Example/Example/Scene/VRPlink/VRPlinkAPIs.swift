//
//  VRPlinkAPIs.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct VRPlinkAPIs: View {
    
    @State private var url: URL? = nil
    
    var body: some View {
        List {
            Section {
                NavigationLink(L10n.vrplinkOpenTitle.localizedKey, destination: VRPlinkOpen())
                NavigationLink(L10n.vrplinkInitiateTitle.localizedKey, destination: VRPlinkInitiate())
            }
            Section {
                NavigationLink(L10n.vrplinkCreateTitle.localizedKey, destination: VRPlinkCreate())
                NavigationLink(L10n.vrplinkGetTitle.localizedKey, destination: VRPlinkGet())
                NavigationLink(L10n.vrplinkDeactivateTitle.localizedKey, destination: VRPlinkDeactivate())
                NavigationLink(L10n.vrplinkListRecordsTitle.localizedKey, destination: VRPlinkListRecords())
            }
        }
        .navigationBarTitle(L10n.vrplinkTitle.localizedKey)
        .safari(APIDocuments.VRPlink.base)
    }
}

struct VRPlinkAPIs_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkAPIs()
    }
}
