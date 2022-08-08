//
//  PayByBankCurrency.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankCurrency
/// Currency codes in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
public enum PayByBankCurrency: String, Codable {
    
    /// British pound sterling.
    case pound = "GBP"
    
    /// United States dollar.
    case usd = "USD"
    
    /// European Monetary Unit.
    case euro = "EUR"
}
