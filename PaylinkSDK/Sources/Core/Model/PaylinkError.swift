//
//  PaylinkError.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 30.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

public enum PaylinkError: Error {
    /// Unknown error.
    case unknown(Error? = nil)
    /// Wrong `clientID` or `clientSecret`.
    case notConfigured
    /// Wrong Paylink.
    case wrongPaylink
    /// Network Error.
    case network(NetworkError)
    
    init(error: Error) {
        switch error {
        case is PaylinkError: self = error as! PaylinkError
        case is NetworkError: self = .network(error as! NetworkError)
        default: self = .unknown(error)
        }
    }
    
    public var localizedDescription: String {
        switch self {
        case .unknown(let error):
            let message = "Unknown error."
            guard let error = error else {
                return message
            }
            return "\(message) (\(error))"
        case .notConfigured:
            return "Wrong `clientID` or `clientSecret`."
        case .wrongPaylink:
            return "Wrong Paylink."
        case .network(let networkError):
            return "Network Error: \(networkError.localizedDescription)"
        }
    }
}
