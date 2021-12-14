//
//  PaylinkService.swift
//  PaylinkMobileSDK-iOS
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

public protocol PaylinkServiceType {
    
    typealias PaylinkResponseHandler<T: Codable> = (Result<T, SDKNetworkError>) -> Void
    
    func getToken(handler: @escaping PaylinkResponseHandler<TempModel>)
    func createPaylink(request: TempRequestModel, handler: @escaping PaylinkResponseHandler<TempModel>)
    func getPaylink(paylinkId: String, handler: @escaping PaylinkResponseHandler<TempModel>)
    func deactivatePaylink(paylinkId: String, handler: @escaping PaylinkResponseHandler<TempModel>)
    func listPayments(paylinkId: String, handler: @escaping PaylinkResponseHandler<[TempModel]>)
    func listAllPayments(handler: @escaping PaylinkResponseHandler<[TempModel]>)
    func getPayment(paymentId: String, handler: @escaping PaylinkResponseHandler<TempModel>)
}

public class PaylinkService: PaylinkServiceType {
    
    public init() {}
    
    public func getToken(handler: @escaping PaylinkResponseHandler<TempModel>) {
        SDKNetworkLayer.request(router: PaylinkAPI.getToken, decode: TempModel.self) { result in
            handler(result)
        }
    }
    
    public func createPaylink(request: TempRequestModel, handler: @escaping PaylinkResponseHandler<TempModel>) {
        SDKNetworkLayer.request(router: PaylinkAPI.createPaylink(request: request), decode: TempModel.self) { result in
            handler(result)
        }
    }
    
    public func getPaylink(paylinkId: String, handler: @escaping PaylinkResponseHandler<TempModel>) {
        SDKNetworkLayer.request(router: PaylinkAPI.getPaylink(paylinkId: paylinkId), decode: TempModel.self) { result in
            handler(result)
        }
    }
    
    public func deactivatePaylink(paylinkId: String, handler: @escaping PaylinkResponseHandler<TempModel>) {
        SDKNetworkLayer.request(router: PaylinkAPI.deactivatePaylink(paylinkId: paylinkId), decode: TempModel.self) { result in
            handler(result)
        }
    }
    
    public func listPayments(paylinkId: String, handler: @escaping PaylinkResponseHandler<[TempModel]>) {
        SDKNetworkLayer.request(router: PaylinkAPI.listPayments(paylinkId: paylinkId), decode: [TempModel].self) { result in
            handler(result)
        }
    }
    
    public func listAllPayments(handler: @escaping PaylinkResponseHandler<[TempModel]>) {
        SDKNetworkLayer.request(router: PaylinkAPI.listAllPayments, decode: [TempModel].self) { result in
            handler(result)
        }
    }
    
    public func getPayment(paymentId: String, handler: @escaping PaylinkResponseHandler<TempModel>) {
        SDKNetworkLayer.request(router: PaylinkAPI.getPayment(paymentId: paymentId), decode: TempModel.self) { result in
            handler(result)
        }
    }
}

// TODO: Create all models
public struct TempModel: Codable {
    
}

// TODO: Create all models
public struct TempRequestModel: Codable {
    
}
