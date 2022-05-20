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
            HStack {
                Text(L10n.ConfigurationEnvironment.localizedKey)
                Spacer()
                Menu(environment.rawValue) {
                    Button(L10n.configurationEnvironmentSandbox.localizedKey) { environment = .sandbox }
                    Button(L10n.configurationEnvironmentProduction.localizedKey) { environment = .production }
                }
                .foregroundColor(.gray)
            }
            HStack {
                Text(L10n.configurationEnvironmentClientID.localizedKey)
                TextField("", text: $clientID)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(L10n.configurationEnvironmentClientSecret.localizedKey)
                TextField("", text: $clientSecret)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
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
