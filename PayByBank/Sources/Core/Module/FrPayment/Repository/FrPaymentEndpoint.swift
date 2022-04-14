//
//  FrPaymentEndpoint.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum FrPaymentEndpoint {
    case createFrPayment(FrPaymentCreateRequest)
    case getFrPayment(FrPaymentGetRequest)
    case deleteFrPayment(FrPaymentDeleteRequest)
}

extension FrPaymentEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PayByBankState.Config.environment.frPaymentEndpointURL
    }
    
    var path: String {
        switch self {
        case .createFrPayment: return "/fr-payments"
        case .getFrPayment(let request): return "/fr-payments/\(request.frPaymentID)"
        case .deleteFrPayment(let request): return "/fr-payments/\(request.frPaymentID)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createFrPayment: return .post
        case .getFrPayment: return .get
        case .deleteFrPayment: return .delete
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
        case .createFrPayment, .getFrPayment, .deleteFrPayment: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createFrPayment(let body): return body
        case .getFrPayment, .deleteFrPayment: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createFrPayment, .getFrPayment, .deleteFrPayment: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createFrPayment, .getFrPayment, .deleteFrPayment: return .data
        }
    }
}
