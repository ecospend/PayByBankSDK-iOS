//
//  PaylinkEndpoint.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 15.12.2021.
//

import Foundation

enum PaylinkEndpoint {
    case createPaylink(PaylinkCreateRequest)
    case getPaylink(PaylinkGetRequest)
    case deletePaylink(PaylinkDeleteRequest)
    case getPayments(PaylinkPaymentGetRequest)
}

extension PaylinkEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PaylinkState.Config.environment.paylinkEndpointURL
    }
    
    var path: String {
        switch self {
        case .createPaylink: return "/paylinks"
        case .getPaylink(let request): return "/paylinks/\(request.paylinkID)"
        case .deletePaylink(let request): return "/paylinks/\(request.paylinkID)"
        case .getPayments(let request): return "/paylinks/\(request.paylinkID)/payments"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createPaylink: return .post
        case .getPaylink, .getPayments: return .get
        case .deletePaylink: return .delete
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
        case .createPaylink, .getPaylink, .deletePaylink, .getPayments: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createPaylink(let body): return body
        case .getPaylink, .deletePaylink, .getPayments: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createPaylink, .getPaylink, .deletePaylink, .getPayments: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createPaylink, .getPaylink, .deletePaylink, .getPayments: return .data
        }
    }
}
