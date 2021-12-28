//
//  PaylinkInitiateMethodFlutterHandler.swift
//  Runner
//
//  Created by Berk Akkerman on 28.12.2021.
//

import Flutter

class PaylinkInitiateMethodFlutterHandler: PaylinkFlutterMethodHandler {
    
    func handle(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
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
        self.initiate(request: request, flutterResult: result)
    }
}

// MARK: - Initiate
extension PaylinkInitiateMethodFlutterHandler {
    
    public func initiate(request: PaylinkCreateRequest, flutterResult: @escaping FlutterResult) {
        guard let rootViewController = PaylinkFlutterModule.rootViewController else { return }
        
        PaylinkSDK.shared.initiate(request: request, viewController: rootViewController) { result in
            switch result {
            case .success(let model):
                flutterResult(model)
            case .failure(let error):
                flutterResult(error)
            }
        }
    }
}
