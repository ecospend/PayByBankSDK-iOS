//
//  PayByBankAccountResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankAccountResponse
public struct PayByBankAccountResponse: Codable {
    
    /// - Enum: "SortCode" "Iban" "Bban"
    public let type: PayByBankAccountType?
    
    /// The identification that you provided with the request.
    public let identification: String?
    
    /// The owner_name that you provided with the PaymentRequest.
    public let name: String?
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency?
    
    /// The bic that you provided with the PaymentRequest (if any).
    public let bic: String?
}
