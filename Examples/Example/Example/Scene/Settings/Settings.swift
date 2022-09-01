//
//  Settings.swift
//  Example
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct Settings: View {
    
    @AppStorage(Self.storage(key: .settingsEnvironment)) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(Self.storage(key: .settingsAccessToken)) var accessToken: String = ""
    @AppStorage(Self.storage(key: .settingsTokenType)) var tokenType: String = "Bearer"
    
    var body: some View {
        Form {
            Menu(environment.rawValue) {
                Button(L10n.settingsEnvironmentSandbox.localizedKey) { environment = .sandbox }
                Button(L10n.settingsEnvironmentProduction.localizedKey) { environment = .production }
            }
            .titled(L10n.settingsEnvironment.localized)
            TextField("", text: $accessToken)
                .titled(L10n.settingsEnvironmentAccessToken.localized)
            TextField("", text: $tokenType)
                .titled(L10n.settingsEnvironmentTokenType.localized)
        }
        .navigationTitle(L10n.settingsTitle.localizedKey)
        .onDisappear {
            PayByBank.configure(environment: environment,
                                accessToken: accessToken,
                                tokenType: tokenType)
        }
        .safari(APIDocuments.Authentication.base)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
