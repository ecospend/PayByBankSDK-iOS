//
//  DatalinkEndpoint.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

enum DatalinkEndpoint {
    case create(DatalinkCreateRequest)
    case get(DatalinkGetRequest)
    case delete(DatalinkDeleteRequest)
    case getConsentDatalink(DatalinkGetConsentDatalinkRequest)
}

extension DatalinkEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PayByBankState.Config.environment.datalinkEndpointURL
    }
    
    var path: String {
        switch self {
        case .create: return "/datalink"
        case .get(let request): return "/datalink/\(request.uniqueID)"
        case .delete(let request): return "/datalink/\(request.uniqueID)"
        case .getConsentDatalink(let request): return "/datalink/consent/\(request.consentID)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .create: return .post
        case .get, .getConsentDatalink: return .get
        case .delete: return .delete
        }
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        if let token = PayByBankState.Network.token,
           let tokenType = token.tokenType,
           let accessToken = token.accessToken {
            headers["Authorization"] = "\(tokenType) \(accessToken)"
        }
        headers["Content-Type"] = bodySchema?.rawValue ?? RequestBodySchema.json.rawValue
        return headers
    }
    
    var parameters: [String: Any?]? {
        return nil
    }
    
    var body: Encodable? {
        switch self {
        case .create(let body): return body
        default: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        return .json
    }
    
    var requestType: RequestType {
        return .data
    }
}
