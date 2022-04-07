//
//  PayByBankAccountType.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankAccountType
public enum PayByBankAccountType: String, Codable {
    case sortCode = "SortCode"
    case iban = "Iban"
    case bban = "Bban"
}
