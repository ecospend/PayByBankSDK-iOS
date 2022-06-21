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
    
    @AppStorage(Self.storage(key: .settingsEnvironment)) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(Self.storage(key: .settingsClientID)) var clientID: String = ""
    @AppStorage(Self.storage(key: .settingsClientSecret)) var clientSecret: String = ""
    
    var body: some View {
        Form {
            Menu(environment.rawValue) {
                Button(L10n.settingsEnvironmentSandbox.localizedKey) { environment = .sandbox }
                Button(L10n.settingsEnvironmentProduction.localizedKey) { environment = .production }
            }
            .titled(L10n.settingsEnvironment.localized)
            TextField("", text: $clientID)
                .titled(L10n.settingsEnvironmentClientID.localized)
            TextField("", text: $clientSecret)
                .titled(L10n.settingsEnvironmentClientSecret.localized)
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
