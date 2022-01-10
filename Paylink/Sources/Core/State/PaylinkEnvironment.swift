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
    var paylinkURL: String { get }
    var localizableTableName: String { get }
}

public enum PaylinkEnvironment {
    case production
    case sandbox
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
        case .production: return "https://pis-api.ecospend.com/api/v2.0"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.0"
        }
    }
    
    var paylinkURL: String {
        switch self {
        case .production: return "https://paylinkv2.ecospend.com"
        case .sandbox: return "https://paylinkv2.sb.ecospend.com"
        }
    }
    
    var localizableTableName: String {
        return "Paylink"
    }
}
