//
//  PaylinkEndpoint.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

enum PaylinkEndpoint {
    case createPaylink(PaylinkCreateRequest)
    case getPaylink(PaylinkGetRequest)
}

extension PaylinkEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PaylinkState.Config.environment.paylinkEndpointURL
    }
    
    var path: String {
        switch self {
        case .createPaylink: return "/paylinks"
        case .getPaylink(let request): return "/paylinks/\(request.paylinkID)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createPaylink: return .post
        case .getPaylink: return .get
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
        case .createPaylink, .getPaylink: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createPaylink(let body): return body
        case .getPaylink: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createPaylink, .getPaylink: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createPaylink, .getPaylink: return .data
        }
    }
}
