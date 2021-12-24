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
    
    @objc(configure:clientSecret:)
    func configure(_ clientID: String, clientSecret: String) {
        PaylinkSDK.shared.configure(clientID: clientID, clientSecret: clientSecret)
    }
}

// TODO: - Example(Delete this extension)
extension PaylinkReactModule {
    
    @objc(authenticate:resolver:rejecter:)
    func authenticate(_ name:  String,
                      resolver resolve: RCTPromiseResolveBlock,
                      rejecter reject:RCTPromiseRejectBlock) -> Void {
        
        if name.contains("a") {
            resolve(true)
        } else {
            reject("401",
                   "Authentication Failed",
                   NSError(domain: "Authentication", code: 401, userInfo: ["code": "401", "domain": "ExamplePromise"]))
        }
    }
    
    @objc func openNativeVC() {
        DispatchQueue.main.async {
            guard let viewController = UIApplication.shared.windows.first?.rootViewController else { return }
            let vc = UIViewController()
            vc.view.backgroundColor = .red
            let nc = UINavigationController(rootViewController: vc)
            viewController.present(nc, animated: true, completion: nil)
        }
    }
    
    @objc func beep() {
        AudioServicesPlaySystemSound(1052)
    }
}
