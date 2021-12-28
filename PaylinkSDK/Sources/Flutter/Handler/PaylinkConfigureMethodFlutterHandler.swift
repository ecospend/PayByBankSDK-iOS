//
//  PaylinkConfigureFlutterHandler.swift
//  Runner
//
//  Created by Berk Akkerman on 28.12.2021.
//

class PaylinkConfigureMethodFlutterHandler: PaylinkFlutterMethodHandler {
    
    func handle(methodCall: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = methodCall.arguments as? [String: Any],
              let clientID = arguments["clientID"] as? String,
              let clientSecret = arguments["clientSecret"] as? String else { return }
        self.configure(clientID: clientID, clientSecret: clientSecret, flutterResult: result)
    }
}

// MARK: - Configure
extension PaylinkConfigureMethodFlutterHandler {
    
    public func configure(environment: PaylinkEnvironment = .sandbox, clientID: String, clientSecret: String, flutterResult: FlutterResult) {
        PaylinkSDK.shared.configure(.sandbox, clientID: clientID, clientSecret: clientSecret)
        flutterResult(())
    }
}


