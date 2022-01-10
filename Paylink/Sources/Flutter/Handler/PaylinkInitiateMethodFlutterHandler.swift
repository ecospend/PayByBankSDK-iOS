//
//  PaylinkInitiateMethodFlutterHandler.swift
//  Runner
//
//  Created by Berk Akkerman on 28.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Flutter

class PaylinkInitiateMethodFlutterHandler: PaylinkFlutterMethodHandler {
    
    var rootViewController: UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? FlutterAppDelegate,
              let controller = appDelegate.window?.rootViewController else { return nil }
        return controller
    }
    
    func handle(methodCall: FlutterMethodCall, sink: @escaping FlutterEventSink) {
        guard let arguments = methodCall.arguments as? [String: Any],
              let redirectUrlString = arguments["redirect_url"] as? String,
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
        self.initiate(request: request, sink: sink)
    }
}

// MARK: - Initiate
extension PaylinkInitiateMethodFlutterHandler {
    
    public func initiate(request: PaylinkCreateRequest, sink: @escaping FlutterEventSink) {
        guard let rootViewController = PaylinkFlutterModule.rootViewController else { return }
        
        Paylink.shared.initiate(request: request, viewController: rootViewController) { result in
            switch result {
                case .success(let model):
                    guard let paymentResult = model.dictionary else { return }
                    sink(paymentResult)
                case .failure(let error):
                    let flutterError = FlutterError(code: "Initiate Error", message: error.localizedDescription, details: (error as NSError).userInfo)
                    sink(flutterError)
            }
        }
    }
}
