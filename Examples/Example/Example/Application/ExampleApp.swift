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
