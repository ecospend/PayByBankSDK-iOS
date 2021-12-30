//
//  PaylinkError.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 30.12.2021.
//

import Foundation

public enum PaylinkError: Error {
    case unknown(Error? = nil)
    case notConfigured
    case wrongPaylink
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
            return "\(message) (\(error)"
        case .notConfigured:
            return "Wrong `clientID` or `clientSecret`."
        case .wrongPaylink:
            return "Wrong Paylink."
        case .network(let networkError):
            return "Network Error: \(networkError.localizedDescription)"
        }
    }
}
