//
//  PaylinkEnvironment.swift
//  Paylink
//
//  Created by Yunus TÜR on 24.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

protocol PaylinkEnvironmentProtocol {
    var iamEndpointURL: String { get }
    var paylinkEndpointURL: String { get }
    var localizableTableName: String { get }
}

public enum PaylinkEnvironment: String {
    case production = "Production"
    case sandbox = "Sandbox"
}

extension PaylinkEnvironment: PaylinkEnvironmentProtocol {
    
    var iamEndpointURL: String {
        switch self {
        case .production: return "https://iam.ecospend.com"
        case .sandbox: return "https://iamapi-px01.ecospend.com"
        }
    }
    
    var paylinkEndpointURL: String {
        switch self {
        case .production: return "https://pis-api.ecospend.com/api/v2.1"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.1"
        }
    }
    
    var localizableTableName: String {
        return "Paylink"
    }
}
