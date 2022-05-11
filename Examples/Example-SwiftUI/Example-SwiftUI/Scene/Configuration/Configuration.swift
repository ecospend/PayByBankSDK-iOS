//
//  Configuration.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct Configuration: View {
    
    @AppStorage(AppStorageKeys.Configuration.environment) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(AppStorageKeys.Configuration.clientID) var clientID: String = ""
    @AppStorage(AppStorageKeys.Configuration.clientSecret) var clientSecret: String = ""
    
    var body: some View {
        Form {
            Picker(L10n.ConfigurationEnvironment.localizedKey, selection: $environment) {
                Text(L10n.configurationEnvironmentSandbox.localizedKey)
                    .tag(PayByBankEnvironment.sandbox)
                Text(L10n.configurationEnvironmentProduction.localizedKey)
                    .tag(PayByBankEnvironment.production)
            }
            TextField(L10n.configurationEnvironmentClientID.localizedKey, text: $clientID)
            TextField(L10n.configurationEnvironmentClientSecret.localizedKey, text: $clientSecret)
        }
        .navigationTitle(L10n.configurationTitle.localizedKey)
        .onDisappear {
            PayByBank.configure(environment: environment,
                                clientID: clientID,
                                clientSecret: clientSecret)
        }
    }
}

struct Configuration_Previews: PreviewProvider {
    static var previews: some View {
        Configuration()
    }
}
