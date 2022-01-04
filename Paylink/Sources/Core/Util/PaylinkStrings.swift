//
//  PaylinkStrings.swift
//  Paylink
//
//  Created by Yunus TÜR on 3.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum PaylinkStrings {
    // MARK: - Network Error
    case network_error_no_data
    case network_error_invalid_response
    case network_error_bad_request(Int)
    case network_error_server_error(Int)
    case network_error_parse_error
    case network_error_unknown
    case network_error_invalid_url(String)
    // MARK: - Paylink Error
    case paylink_error_unknown
    case paylink_error_not_configured
    case paylink_error_wrong_paylink
    case paylink_error_network(String)
    // MARK: - Detailed Error
    case detailed_error(String, String)
}

extension PaylinkStrings {
    
    var name: String {
        String("\(self)".split(separator: "(").first ?? "")
    }
    
    var arguments: [CVarArg]? {
        switch self {
        case .network_error_bad_request(let status): return [status]
        case .network_error_server_error(let status): return [status]
        case .network_error_invalid_url(let endpoint): return [endpoint]
        case .paylink_error_network(let networkError): return [networkError]
        case .detailed_error(let error, let message): return [error, message].toCVarArg()
        default: return nil
        }
    }
    
    var localized: String {
        let value = NSLocalizedString(name,
                                      tableName: PaylinkState.Config.environment.localizableTableName,
                                      bundle:  Bundle(for: Paylink.self),
                                      comment: "")
        guard let arguments = arguments else { return value }
        return String(format: value, arguments: arguments.map { String(describing: $0) })
    }
}