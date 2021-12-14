//
//  PaylinkAPI.swift
//  SpeedyPaySDK
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

enum PaylinkAPI {
    case getToken
    case createPaylink(request: TempRequestModel)
    case getPaylink(paylinkId: String)
    case deactivatePaylink(paylinkId: String)
    case listPayments(paylinkId: String)
    case listAllPayments
    case getPayment(paymentId: String)
}

extension PaylinkAPI: SDKAPIType {
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "pis-api-sandbox.ecospend.com"
    }
    
    var versionPrefix: String {
        return "/api/v2.0"
    }
    
    var headers: [String: String] {
        return [
            "Accept": "application/json; charset=utf-8",
            "Content-Type": "application/json",
            "x-platform": "IOS"
        ]
    }
    
    var method: SDKHTTPMethod {
        switch self {
        case .createPaylink:
            return .POST
        case .getToken, .getPaylink, .listPayments, .listAllPayments, .getPayment:
            return .GET
        case .deactivatePaylink:
            return .DELETE
        }
    }
    
    var endpoint: String {
        switch self {
        case .getToken:
            return "/token"
        case .createPaylink:
            return "/paylinks"
        case .getPaylink(let paylinkId), .deactivatePaylink(let paylinkId):
            return "/paylinks/\(paylinkId)"
        case .listPayments(let paylinkId):
            return "/paylinks/\(paylinkId)/payments"
        case .listAllPayments:
            return "/paylinks/payments"
        case .getPayment(let paymentId):
            return "/paylinks/payments/\(paymentId)"
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .createPaylink(let request):
            return request.dictionary
        default:
            return nil
        }
    }
}
