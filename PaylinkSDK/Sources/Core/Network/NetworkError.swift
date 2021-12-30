//
//  NetworkError.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 13.12.2021.
//

import Foundation

/// Enum of API Errors
public enum NetworkError: Error {
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
    case unknown(String?)
    
    public var localizedDescription: String {
        switch self {
        case .noData:
            return "No data received from the server."
        case .invalidResponse:
            return "The server response was invalid (unexpected format)."
        case .badRequest(let error):
            let message = "The request was rejected: 400-499."
            guard let error = error else {
                return message
            }
            return "\(message) (\(error)"
        case .serverError(let error):
            let message = "Encoutered a server error."
            guard let error = error else {
                return message
            }
            return "\(message) (\(error)"
        case .parseError(let error):
            let message = "There was an error parsing the data."
            guard let error = error else {
                return message
            }
            return "\(message) (\(error)"
        case .unknown(let error):
            let message = "Unknown error."
            guard let error = error else {
                return message
            }
            return "\(message) (\(error)"
        }
    }
}
