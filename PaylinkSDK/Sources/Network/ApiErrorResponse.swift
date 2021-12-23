//
//  ApiErrorResponse.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//

import Foundation

struct ApiErrorResponse: Codable {
    let error: ApiError?
    let descrpition: String?
    let details: [String: [String]]?
}

extension ApiErrorResponse: Error {
    
    var localizedDescription: String? {
        return details?.values.reduce([]) { $0 + $1 }.joined(separator: ",") ?? descrpition
    }
}

// MARK: - ApiError
enum ApiError: String, Codable {
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
        self = try ApiError(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
