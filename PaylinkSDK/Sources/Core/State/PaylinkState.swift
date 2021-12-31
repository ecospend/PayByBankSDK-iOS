//
//  PaylinkState.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

struct PaylinkState {
    
    struct Config {
        static var environment: PaylinkEnvironment = .sandbox
        static var clientID: String?
        static var clientSecret: String?
    }
    
    struct Network {
        static var token: IamTokenResponse?
    }
}
