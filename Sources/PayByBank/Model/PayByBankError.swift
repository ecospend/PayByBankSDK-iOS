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
    /// Wrong Link.
    case wrongLink
}

// MARK: - LocalizedError
extension PayByBankError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .wrongLink:
            return PayByBankStrings.paybybank_error_wrong_link.localized
        }
    }
}
