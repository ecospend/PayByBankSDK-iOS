//
//  RepositoryErrorResponse.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - RepositoryErrorResponse
struct RepositoryErrorResponse: Codable {
    let error: RepositoryErrorType?
    let description: String?
    let details: [String: [String]]?
    
    var localizedDescription: String? {
        return details?.values.reduce([]) { $0 + $1 }.joined(separator: ",") ?? description
    }
}

// MARK: - RepositoryError
enum RepositoryErrorType: String, Codable {
    case unknown = "Unknown"
    case noError = "NoError"
    case authorizationError = "AuthorizationError"
    case invalidRequest = "InvalidRequest"
    case unprocessableEntityError = "UnprocessableEntityError"
    case notFoundError = "NotFoundError"
    case invalidBankRequest = "InvalidBankRequest"
    case internalServerError = "InternalServerError"
    case bankServiceError = "BankServiceError"
    case externalServerError = "ExternalServerError"
    case redirectServerError = "RedirectServerError"
    
    public init(from decoder: Decoder) throws {
        self = try RepositoryErrorType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
