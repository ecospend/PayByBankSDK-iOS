//
//  PaylinkError.swift
//  Paylink
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

public enum PaylinkError: Error {
    /// Unknown error.
    case unknown(Error?)
    /// Wrong `clientID` or `clientSecret`.
    case notConfigured
    /// Wrong Paylink.
    case wrongPaylink
    /// Network Error.
    case network(NetworkError)
    
    init(error: Error) {
        switch error {
        case is PaylinkError: self = error as! PaylinkError
        case is NetworkError: self = .network(error as! NetworkError)
        default: self = .unknown(error)
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .unknown(let message):
            let error = PaylinkStrings.paylink_error_unknown.localized
            guard let message = message else { return error }
            return PaylinkStrings.detailed_error(error, message.localizedDescription).localized
        case .notConfigured:
            return PaylinkStrings.paylink_error_not_configured.localized
        case .wrongPaylink:
            return PaylinkStrings.paylink_error_wrong_paylink.localized
        case .network(let networkError):
            return PaylinkStrings.paylink_error_network(networkError.localizedDescription).localized
        }
    }
}
