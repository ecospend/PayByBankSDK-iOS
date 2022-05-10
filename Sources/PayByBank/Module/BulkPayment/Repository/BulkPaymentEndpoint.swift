//
//  BulkPaymentEndpoint.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum BulkPaymentEndpoint {
    case createBulkPayment(BulkPaymentCreateRequest)
    case getBulkPayment(BulkPaymentGetRequest)
    case deleteBulkPayment(BulkPaymentDeleteRequest)
}

extension BulkPaymentEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PayByBankState.Config.environment.paylinkEndpointURL
    }
    
    var path: String {
        switch self {
        case .createBulkPayment: return "/bulk-payment-paylinks"
        case .getBulkPayment(let request): return "/bulk-payment-paylinks/\(request.uniqueID)"
        case .deleteBulkPayment(let request): return "/bulk-payment-paylinks/\(request.uniqueID)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createBulkPayment: return .post
        case .getBulkPayment: return .get
        case .deleteBulkPayment: return .delete
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
        case .createBulkPayment, .getBulkPayment, .deleteBulkPayment: return nil
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createBulkPayment(let body): return body
        case .getBulkPayment, .deleteBulkPayment: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createBulkPayment, .getBulkPayment, .deleteBulkPayment: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createBulkPayment, .getBulkPayment, .deleteBulkPayment: return .data
        }
    }
}
