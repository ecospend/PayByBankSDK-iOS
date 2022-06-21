//
//  Example_SwiftUIApp.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 10.05.2022.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

@main
struct Example_SwiftUIApp: App {
    
    @AppStorage(Settings.storage(key: .settingsEnvironment)) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(Settings.storage(key: .settingsClientID)) var clientID: String = ""
    @AppStorage(Settings.storage(key: .settingsClientSecret)) var clientSecret: String = ""
    
    init() {
        PayByBank.configure(environment: environment,
                            clientID: clientID,
                            clientSecret: clientSecret)
    }
    
    var body: some Scene {
        WindowGroup {
            ToastView {
                LoadingView {
                    HomeView()
                }
            }
        }
    }
}
