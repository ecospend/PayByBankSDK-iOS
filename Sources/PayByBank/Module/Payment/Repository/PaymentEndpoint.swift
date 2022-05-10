//
//  PaymentEndpoint.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum PaymentEndpoint {
    case createPayment(PaymentCreateRequest)
    case getPayment(PaymentGetRequest)
    case listPayments(PaymentListRequest)
    case checkPaymentURL(PaymentCheckURLRequest)
    case createRefund(PaymentCreateRefundRequest)
}

extension PaymentEndpoint: EndpointProtocol {
    
    var baseURL: String {
        return PayByBankState.Config.environment.paymentEndpointURL
    }
    
    var path: String {
        switch self {
        case .createPayment, .listPayments: return "/payments"
        case .getPayment(let request): return "/payments/\(request.id)"
        case .checkPaymentURL(let request): return "/payments/\(request.id)/url-consumed"
        case .createRefund(let request): return "/payments/\(request.id)/refund"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .createPayment, .createRefund: return .post
        case .listPayments, .getPayment, .checkPaymentURL: return .get
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
        case .createPayment, .getPayment, .createRefund, .checkPaymentURL: return nil
        case .listPayments(let request): return request.dictionary
        }
    }
    
    var body: Encodable? {
        switch self {
        case .createPayment(let request): return request
        case .createRefund(let request): return request
        case .listPayments, .getPayment, .checkPaymentURL: return nil
        }
    }
    
    var bodySchema: RequestBodySchema? {
        switch self {
        case .createPayment, .listPayments, .getPayment, .checkPaymentURL, .createRefund: return .json
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .createPayment, .listPayments, .getPayment, .checkPaymentURL, .createRefund: return .data
        }
    }
}
