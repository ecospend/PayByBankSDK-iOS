//
//  PaylinkFlutterModule.swift
//  PaylinkSDK
//
//  Created by Berk Akkerman on 27.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Flutter

public class PaylinkFlutterModule {
    
    public static let shared = PaylinkFlutterModule()
    
    public var channelName: String {
        return "paylink/flutter"
    }
    
    static var rootViewController: UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? FlutterAppDelegate,
              let controller = appDelegate.window?.rootViewController else { return nil }
        return controller
    }
    
    private var channel: FlutterMethodChannel!
    
    private init() {
        channel = FlutterMethodChannel(name: channelName, binaryMessenger: Self.rootViewController as! FlutterBinaryMessenger)
    }
    
    public func start() {
       
        handleMethods()
    }
    
    private func handleMethods() {
        channel.setMethodCallHandler { (methodCall: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let method = PaylinkFlutterMethod(rawValue: methodCall.method) else {
                print("Unknown method invoked")
                return
            }
            method.handler.handle(methodCall: methodCall, result: result)
        }
    }
}
