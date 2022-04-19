//
//  PayByBankAccountRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

// swiftlint:disable line_length

import Foundation

// MARK: - PayByBankAccountRequest
public struct PayByBankAccountRequest: Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    public let type: PayByBankAccountType
    
    /// Account identification. The value of this parameter depends on the value of AccountType.
    /// If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between.
    /// For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    public let identification: String
    
    /// Full legal name of the account owner.
    public let name: String
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency
    
    ///  - Parameters:
    ///     - type: Enum: "SortCode" "Iban" "Bban"
    ///     - identification: Account identification. The value of this parameter depends on the value of AccountType. If type = “SortCode” then a 6-digit SortCode appended with a 8-digit Account Number merged into a 14-digit value, with no dashes in between. For type = “IBAN” the IBAN of the account (compliant with [ISO 13616-1](https://en.wikipedia.org/wiki/International_Bank_Account_Number#Structure)) and for type = “BNAN” the BBAN of the account must be set.
    ///     - name: Full legal name of the account owner.
    ///     - currency: Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format. - Enum: "GBP" "USD" "EUR"
    public init(type: PayByBankAccountType,
                identification: String,
                name: String,
                currency: PayByBankCurrency) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
    }
}
