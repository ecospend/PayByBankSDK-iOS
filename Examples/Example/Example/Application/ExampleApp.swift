//
//  ExampleApp.swift
//  Example
//
//  Created by Yunus TÜR on 10.05.2022.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

@main
struct ExampleApp: App {
    
    @AppStorage(Settings.storage(key: .settingsEnvironment)) var environment: PayByBankEnvironment = .sandbox
    @AppStorage(Settings.storage(key: .settingsAccessToken)) var accessToken: String = ""
    @AppStorage(Settings.storage(key: .settingsTokenType)) var tokenType: String = ""
    
    init() {
        PayByBank.configure(environment: environment,
                            accessToken: accessToken,
                            tokenType: tokenType)
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
