//
//  PaylinkReactModule.swift
//  PaylinkSDK
//
//  Created by Berk Akkerman on 23.12.2021.
//

import Foundation
import AVFAudio
import React
import UIKit

@objc(PaylinkReactModule)
class PaylinkReactModule: NSObject {
    
    static var rootViewController: UIViewController? {
        guard let controller = UIApplication.shared.windows.first?.rootViewController else { return nil }
        return controller
    }
    
    @objc(configure:clientSecret:)
    func configure(_ clientID: String, clientSecret: String) {
        PaylinkSDK.shared.configure(.sandbox, clientID: clientID, clientSecret: clientSecret)
    }
    
    @objc(initiate:resolver:rejecter:)
    public func initiate(_ arguments: [String: Any],
                         resolver resolve: @escaping RCTPromiseResolveBlock,
                         rejecter reject: @escaping RCTPromiseRejectBlock) {
        
        DispatchQueue.main.async {
            guard let rootViewController = PaylinkReactModule.rootViewController else { return }
            
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
                    resolve(model)
                case .failure(let error):
                    reject("0",
                           error.localizedDescription,
                           NSError(domain: "PaylinkSDK", code: 0, userInfo: ["code": "0", "domain": "PaylinkSDK"]))
                }
            }
        }
    }
    
    @objc(open:resolver:rejecter:)
    public func open(_ uid: String,
                     resolver resolve: @escaping RCTPromiseResolveBlock,
                     rejecter reject: @escaping RCTPromiseRejectBlock) {
        DispatchQueue.main.async {
            guard let rootViewController = PaylinkReactModule.rootViewController else { return }
            
            PaylinkSDK.shared.open(paylinkID: uid, viewController: rootViewController) { result in
                switch result {
                case .success(let model):
                    resolve(model)
                case .failure(let error):
                    reject("0",
                           error.localizedDescription,
                           NSError(domain: "PaylinkSDK", code: 0, userInfo: ["code": "0", "domain": "PaylinkSDK"]))
                }
            }
            
        }
    }
}
