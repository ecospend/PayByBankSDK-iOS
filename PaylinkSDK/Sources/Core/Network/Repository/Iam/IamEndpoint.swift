//
//  IamEndpoint.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 15.12.2021.
//

import Foundation

enum IamEndpoint {
    case token(IamTokenRequest)
}

extension IamEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return "https://iamapi-px01.ecospend.com"
    }
    
    var path: String {
        switch self {
        case .token: return "/connect/token"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .token: return .post
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": bodySchema?.rawValue ?? ""
        ]
    }
    
    var parameters: [String : Any?]? {
        switch self {
        case .token: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .token(let body): return body
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .token: return .form
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .token: return .data
        }
    }
}
