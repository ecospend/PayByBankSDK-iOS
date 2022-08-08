//
//  PayByBankEnvironment.swift
//  PayByBank
//
//  Created by Yunus TÜR on 24.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankEnvironmentProtocol
protocol PayByBankEnvironmentProtocol {
    var iamEndpointURL: String { get }
    var paylinkEndpointURL: String { get }
    var frPaymentEndpointURL: String { get }
    var vrplinkEndpointURL: String { get }
    var bulkPaymentEndpointURL: String { get }
    var datalinkEndpointURL: String { get }
    var paymentEndpointURL: String { get }
}

// MARK: - PayByBankEnvironment
/// Environments for testing or released applications.
public enum PayByBankEnvironment: String {
    
    /// **Production** environment should be used for released applications.
    case production = "Production"
    
    /// **Sandbox** environment should be used for testing purposes.
    case sandbox = "Sandbox"
}

extension PayByBankEnvironment: PayByBankEnvironmentProtocol {
    
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
    
    var frPaymentEndpointURL: String {
        switch self {
        case .production: return "https://pis-api.ecospend.com/api/v2.1"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.1"
        }
    }
    
    var vrplinkEndpointURL: String {
        switch self {
        case .production: return "https://pis-api.ecospend.com/api/v2.1"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.1"
        }
    }
    
    var bulkPaymentEndpointURL: String {
        switch self {
        case .production: return "https://pis-api.ecospend.com/api/v2.1"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.1"
        }
    }
    
    var datalinkEndpointURL: String {
        switch self {
        case .production: return "https://ais-api.ecospend.com/api/v2.0"
        case .sandbox: return "https://aisapi.sb.ecospend.com/api/v2.0"
        }
    }
    
    var paymentEndpointURL: String {
        switch self {
        case .production: return "https://pis-api.ecospend.com/api/v2.1"
        case .sandbox: return "https://pis-api-sandbox.ecospend.com/api/v2.1"
        }
    }
}
