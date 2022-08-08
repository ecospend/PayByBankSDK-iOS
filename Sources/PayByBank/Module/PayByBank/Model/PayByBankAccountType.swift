//
//  PayByBankAccountType.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankAccountType
/// Formats of the account identification text.
public enum PayByBankAccountType: String, Codable {
    
    /// **Sort code** is a unique identifier of the individual branch or bank office where a bank account is held.
    /// - Warning: Sort code is mandatory when sending a telegraphic transfer to countries such as the United Kingdom or South Africa.
    case sortCode = "SortCode"
    
    /// **The International Bank Account Number** is a unique identifier helping banks process payments from person to person automatically.
    case iban = "Iban"
    
    /// **Basic Bank Account Number** represents a country-specific bank account number.
    case bban = "Bban"
}
