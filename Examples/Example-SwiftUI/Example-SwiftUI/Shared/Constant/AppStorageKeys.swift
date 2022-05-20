//
//  AppStorageKeys.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

struct AppStorageKeys {
    
    struct Configuration {
        static let environment: String = "configuration.environment"
        static let clientID: String = "configuration.clientID"
        static let clientSecret: String = "configuration.clientSecret"
    }
    
    struct Paylink {
        struct Open {
            struct Request {
                static let uniqueID: String = "paylink.open.request.uniqueID"
            }
        }
    }
}
