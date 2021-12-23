//
//  NetworkError.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 13.12.2021.
//

import Foundation

/// Enum of API Errors
enum NetworkError: Error {
    /// No data received from the server.
    case noData
    /// The server response was invalid (unexpected format).
    case invalidResponse
    /// The request was rejected: 400-499
    case badRequest(String?)
    /// Encoutered a server error.
    case serverError(String?)
    /// There was an error parsing the data.
    case parseError(String?)
    /// Unknown error.
    case unknown
}
