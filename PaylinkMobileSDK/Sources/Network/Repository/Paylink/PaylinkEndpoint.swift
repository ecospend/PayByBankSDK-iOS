//
//  PaylinkEndpoint.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 15.12.2021.
//

import Foundation

enum PaylinkEndpoint {
    case createPaylink(PaylinkCreateRequest)
}

extension PaylinkEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return "https://pis-api-sandbox.ecospend.com/api/v2.0"
    }
    
    var path: String {
        switch self {
        case .createPaylink: return "/paylinks"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createPaylink: return .post
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        if let token = PaylinkState.Network.token,
           let tokenType = token.tokenType,
           let accessToken = token.accessToken {
            headers["Authorization"] = "\(tokenType) \(accessToken)"
        }
        headers["Content-Type"] = bodySchema?.rawValue ?? RequestBodySchema.json.rawValue
        return headers
    }
    
    var parameters: [String : Any?]? {
        switch self {
        case .createPaylink: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createPaylink(let body): return body
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createPaylink: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createPaylink: return .data
        }
    }
}
