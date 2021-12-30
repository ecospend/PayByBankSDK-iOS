//
//  PaylinkEnvironment.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 24.12.2021.
//

import Foundation

protocol PaylinkEnvironmentProtocol {
    var iamEndpointURL: String { get }
    var paylinkEndpointURL: String { get }
    var paylinkURL: String { get }
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
        case .production: return "https://paylinkv2.sb.ecospend.com"
        case .sandbox: return "https://paylinkweb-sandbox.ecospend.com"
        }
    }
}
