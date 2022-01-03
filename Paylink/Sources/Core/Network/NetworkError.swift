//
//  NetworkError.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 13.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

/// Enum of API Errors
public enum NetworkError: Error {
    /// No data received from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest(Int, String?)
    /// Encoutered a server error.
    case serverError(Int, String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown(String?)
    
    public var localizedDescription: String {
        switch self {
        case .noData:
            return PaylinkStrings.network_error_no_data.localized
        case .invalidResponse:
            return PaylinkStrings.network_error_invalid_response.localized
        case .badRequest(let status, let message):
            let error = PaylinkStrings.network_error_bad_request(status).localized
            guard let message = message else { return error }
            return PaylinkStrings.detailed_error(error, message).localized
        case .serverError(let status, let message):
            let error = PaylinkStrings.network_error_server_error(status).localized
            guard let message = message else { return error }
            return PaylinkStrings.detailed_error(error, message).localized
        case .parseError(let message):
            let error = PaylinkStrings.network_error_parse_error.localized
            guard let message = message else { return error }
            return PaylinkStrings.detailed_error(error, message).localized
        case .unknown(let message):
            let error = PaylinkStrings.network_error_unknown.localized
            guard let message = message else { return error }
            return PaylinkStrings.detailed_error(error, message).localized
        }
    }
}
