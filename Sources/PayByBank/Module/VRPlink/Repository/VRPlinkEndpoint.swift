//
//  VRPlinkEndpoint.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum VRPlinkEndpoint {
    case createVRPlink(VRPlinkCreateRequest)
    case getVRPlink(VRPlinkGetRequest)
    case deleteVRPlink(VRPlinkDeleteRequest)
    case getVRPlinkRecords(VRPlinkGetRecordsRequest)
}

extension VRPlinkEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PayByBankState.Config.environment.vrplinkEndpointURL
    }
    
    var path: String {
        switch self {
        case .createVRPlink: return "/vrplinks"
        case .getVRPlink(let request): return "/vrplinks/\(request.uniqueID)"
        case .deleteVRPlink(let request): return "/vrplinks/\(request.uniqueID)"
        case .getVRPlinkRecords(let request): return "/vrplinks/\(request.uniqueID)/vrps"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createVRPlink: return .post
        case .getVRPlink, .getVRPlinkRecords: return .get
        case .deleteVRPlink: return .delete
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
        switch self {
        case .createVRPlink, .getVRPlink, .deleteVRPlink, .getVRPlinkRecords: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createVRPlink(let body): return body
        case .getVRPlink, .deleteVRPlink, .getVRPlinkRecords: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createVRPlink, .getVRPlink, .deleteVRPlink, .getVRPlinkRecords: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createVRPlink, .getVRPlink, .deleteVRPlink, .getVRPlinkRecords: return .data
        }
    }
}
