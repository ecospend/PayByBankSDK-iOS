//
//  PayByBankError.swift
//  PayByBank
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

/// Enum of SDK Errors
public enum PayByBankError: Error {
    /// Unknown error.
    case unknown(Error?)
    /// Wrong `clientID` or `clientSecret`.
    case notConfigured
    /// Wrong Link.
    case wrongLink
    /// Network Error.
    case network(NetworkError)
    
    init(error: Error) {
        if let error = error as? PayByBankError {
            self = error
        } else if let error = error as? NetworkError {
            self = .network(error)
        } else {
            self = .unknown(error)
        }
    }
}
// MARK: - LocalizedError
extension PayByBankError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unknown(let message):
            let error = PayByBankStrings.paybybank_error_unknown.localized
            guard let message = message else { return error }
            return PayByBankStrings.detailed_error(error, message.localizedDescription).localized
        case .notConfigured:
            return PayByBankStrings.paybybank_error_not_configured.localized
        case .wrongLink:
            return PayByBankStrings.paybybank_error_wrong_link.localized
        case .network(let networkError):
            return PayByBankStrings.paybybank_error_network(networkError.localizedDescription).localized
        }
    }
}
