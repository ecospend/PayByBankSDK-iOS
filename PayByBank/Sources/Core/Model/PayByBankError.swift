//
//  PayByBankError.swift
//  PayByBank
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

public enum PayByBankError: LocalizedError {
    /// Unknown error.
    case unknown(Error?)
    /// Wrong `clientID` or `clientSecret`.
    case notConfigured
    /// Wrong Link.
    case wrongLink
    /// Network Error.
    case network(NetworkError)
    
    init(error: Error) {
        switch error {
        case is PayByBankError: self = error as! PayByBankError
        case is NetworkError: self = .network(error as! NetworkError)
        default: self = .unknown(error)
        }
    }
    
    public var localizedDescription: String {
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
