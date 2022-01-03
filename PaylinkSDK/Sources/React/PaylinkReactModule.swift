//
//  PaylinkReactModule.swift
//  PaylinkSDK
//
//  Created by Berk Akkerman on 23.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation
import AVFAudio
import React
import UIKit

@objc(PaylinkReactModule)
class PaylinkReactModule: RCTEventEmitter {
    
    enum Event: String, CaseIterable {
        case initiate
        case open
    }
    
    // Returns an array of your named events
    override func supportedEvents() -> [String]! {
        return Event.allCases.map { $0.rawValue }
    }
    
    static var rootViewController: UIViewController? {
        guard let controller = UIApplication.shared.windows.first?.rootViewController else { return nil }
        return controller
    }
    
    @objc(configure:clientSecret:)
    func configure(_ clientID: String, clientSecret: String) {
        PaylinkSDK.shared.configure(environment: .sandbox, clientID: clientID, clientSecret: clientSecret)
    }
    
    @objc(initiate:errorCallback:)
    public func initiate(_ arguments: [String: Any],
                         errorCallback: @escaping RCTResponseSenderBlock) {
        
        DispatchQueue.main.async {
            guard let rootViewController = PaylinkReactModule.rootViewController else { return }
            let failure = { (error: Error) in errorCallback([error]) }
            
            guard let redirectUrlString = arguments["redirect_url"] as? String,
                  let redirectURL = URL(string: redirectUrlString),
                  let amount = arguments["amount"] as? Double,
                  let reference = arguments["reference"] as? String,
                  let description = arguments["description"] as? String,
                  let creditorAccountDict = arguments["creditor_account"] as? [String: Any],
                  let creditorAccountTypeString = creditorAccountDict["type"] as? String,
                  let creditorAccountType = PaylinkAccountType(rawValue: creditorAccountTypeString),
                  let creditorIdentification = creditorAccountDict["identification"] as? String,
                  let creditorName = creditorAccountDict["name"] as? String,
                  let currencyString = creditorAccountDict["currency"] as? String,
                  let currency = PaylinkCurrency(rawValue: currencyString)
            else { return }
            
            let request = PaylinkCreateRequest(
                redirectURL: redirectURL.absoluteString,
                amount: Decimal(amount),
                reference: reference,
                description: description,
                creditorAccount: PaylinkAccount(
                    type: creditorAccountType,
                    identification: creditorIdentification,
                    name: creditorName,
                    currency: currency
                )
            )
            
            PaylinkSDK.shared.initiate(request: request, viewController: rootViewController) { result in
                switch result {
                case .success(let model):
                    self.sendEvent(withName: Event.initiate.rawValue, body: model.dictionary)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    
    @objc(open:_:)
    public func open(_ uid: String,
                     _ errorCallback: @escaping RCTResponseSenderBlock) {
        DispatchQueue.main.async {
            guard let rootViewController = PaylinkReactModule.rootViewController else { return }
            let failure = { (error: Error) in errorCallback([error]) }
            
            PaylinkSDK.shared.open(paylinkID: uid, viewController: rootViewController) { result in
                switch result {
                case .success(let model):
                    self.sendEvent(withName: Event.open.rawValue, body: model.dictionary)
                case .failure(let error):
                    failure(error)
                }
            }
            
        }
    }
}
