//
//  PayByBankAccountResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankAccountResponse
/// Response model for bank account.
public struct PayByBankAccountResponse: Codable {
    
    /// Format of the account identification text.
    /// - Note: Enum: "SortCode" "Iban" "Bban"
    public let type: PayByBankAccountType?
    
    /// Account identification. 
    public let identification: String?
    
    /// Full legal name of the account owner.
    public let name: String?
    
    /// Currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    /// - Note: Enum: "GBP" "USD" "EUR"
    public let currency: PayByBankCurrency?
    
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
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - type: Instance's `PayByBankAccountType`, which is format of the account identification text.
    ///     - identification: Account identification.
    ///     - name: Full legal name of the account owner.
    ///     - currency: Instance's `PayByBankCurrency`, which is currency code of the account in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217#Active_codes) format.
    ///     - bic: A standard [ISO 9362](https://en.wikipedia.org/wiki/ISO_9362#Structure) compliant Bank Identifier Code.
    public init(type: PayByBankAccountType?,
                identification: String?,
                name: String?,
                currency: PayByBankCurrency?,
                bic: String?) {
        self.type = type
        self.identification = identification
        self.name = name
        self.currency = currency
        self.bic = bic
    }
}

// MARK: - Decodable & Encodable
public extension PayByBankAccountResponse {
    
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// - Parameters:
    ///     - decoder: The decoder to read data from.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decodeIfPresent(PayByBankAccountType.self, forKey: .type)
        identification = try container.decodeIfPresent(String.self, forKey: .identification)
        name = try {
            guard let name = try? container.decodeIfPresent(String.self, forKey: .name) else {
                return try container.decodeIfPresent(String.self, forKey: .ownerName)
            }
            return name
        }()
        currency = try container.decodeIfPresent(PayByBankCurrency.self, forKey: .currency)
        bic = try container.decodeIfPresent(String.self, forKey: .bic)
    }
    
    /// Encodes instance into the given encoder.
    ///
    /// - Parameters:
    ///     - encoder: The encoder to write data to.
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
