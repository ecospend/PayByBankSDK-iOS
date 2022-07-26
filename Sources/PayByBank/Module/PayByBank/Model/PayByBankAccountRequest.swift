//
//  PayByBankAccountRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

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
    
    /// A standard [ISO 9362](https://en.wikipedia.org/wiki/ISO_9362#Structure) compliant Bank Identifier Code.
    /// It is required for international payments (if either sender or the creditor account is outside the SEPA region).
    public let bic: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case identification
        case name
        case ownerName = "owner_name"
        case currency
        case bic
    }
    
    public init(type: PayByBankAccountType,
                identification: String,
                name: String,
                currency: PayByBankCurrency,
                bic: String? = nil) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
        self.bic = bic
    }
}

// MARK: - Decodable & Encodable
public extension PayByBankAccountRequest {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(PayByBankAccountType.self, forKey: .type)
        identification = try container.decode(String.self, forKey: .identification)
        name = try {
            guard let name = try? container.decode(String.self, forKey: .name) else {
                return try container.decode(String.self, forKey: .ownerName)
            }
            return name
        }()
        currency = try container.decode(PayByBankCurrency.self, forKey: .currency)
        bic = try container.decodeIfPresent(String.self, forKey: .bic)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(identification, forKey: .identification)
        try container.encode(name, forKey: .name)
        try container.encode(name, forKey: .ownerName)
        try container.encode(currency, forKey: .currency)
        try container.encode(bic, forKey: .bic)
    }
}
