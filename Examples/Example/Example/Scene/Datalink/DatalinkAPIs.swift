//
//  DatalinkAPIs.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct DatalinkAPIs: View {
    
    var body: some View {
        List {
            Section {
                NavigationLink(L10n.datalinkOpenNoAuthTitle.localizedKey, destination: DatalinkOpenNoAuth())
                NavigationLink(L10n.datalinkOpenTitle.localizedKey, destination: DatalinkOpen())
                NavigationLink(L10n.datalinkInitiateTitle.localizedKey, destination: DatalinkInitiate())
            }
            Section {
                NavigationLink(L10n.datalinkCreateTitle.localizedKey, destination: DatalinkCreate())
                NavigationLink(L10n.datalinkGetTitle.localizedKey, destination: DatalinkGet())
                NavigationLink(L10n.datalinkDeleteTitle.localizedKey, destination: DatalinkDelete())
                NavigationLink(L10n.datalinkGetOfConsentTitle.localizedKey, destination: DatalinkGetOfConsent())
            }
        }
        .navigationBarTitle(L10n.datalinkTitle.localizedKey)
        .safari(APIDocuments.Datalink.base)
    }
}

struct DatalinkAPIs_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkAPIs()
    }
}
