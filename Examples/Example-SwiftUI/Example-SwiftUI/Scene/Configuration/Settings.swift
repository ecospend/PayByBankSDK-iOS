//
//  Settings.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct Settings: View {
    
    @AppStorage(Self.storage(key: .environment)) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(Self.storage(key: .clientID)) var clientID: String = ""
    @AppStorage(Self.storage(key: .clientSecret)) var clientSecret: String = ""
    
    var body: some View {
        Form {
            HStack {
                Text(L10n.settingsEnvironment.localizedKey)
                Spacer()
                Menu(environment.rawValue) {
                    Button(L10n.settingsEnvironmentSandbox.localizedKey) { environment = .sandbox }
                    Button(L10n.settingsEnvironmentProduction.localizedKey) { environment = .production }
                }
                .foregroundColor(.gray)
            }
            HStack {
                Text(L10n.settingsEnvironmentClientID.localizedKey)
                TextField("", text: $clientID)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
            HStack {
                Text(L10n.settingsEnvironmentClientSecret.localizedKey)
                TextField("", text: $clientSecret)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle(L10n.settingsTitle.localizedKey)
        .onDisappear {
            PayByBank.configure(environment: environment,
                                clientID: clientID,
                                clientSecret: clientSecret)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
