//
//  PayByBankFlutterModule.swift
//  PayByBank
//
//  Created by Berk Akkerman on 27.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Flutter

public class PaylinkFlutterModule: NSObject {
    
    public static let shared = PaylinkFlutterModule()
    
    private var channelName: String {
        return "paylink/flutter"
    }
    
    private var eventChannelName: String {
        return "paylink/initiateEvent"
    }
    
    static var rootViewController: UIViewController? {
        guard let appDelegate = UIApplication.shared.delegate as? FlutterAppDelegate,
              let controller = appDelegate.window?.rootViewController else { return nil }
        return controller
    }
    
    private var channel: FlutterMethodChannel!
    private var eventChannel: FlutterEventChannel!
    private var eventSink: FlutterEventSink?
    
    private override init() {
        super.init()        
    }
    
    public func start() {
        guard let binaryMessenger = Self.rootViewController as? FlutterBinaryMessenger else { return }
        channel = FlutterMethodChannel(name: channelName, binaryMessenger: binaryMessenger)
        eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: binaryMessenger)
        eventChannel.setStreamHandler(self)
        handleMethods()
    }
    
    private func handleMethods() {
        channel.setMethodCallHandler { (methodCall: FlutterMethodCall, _: @escaping FlutterResult) in
            guard let method = PaylinkFlutterMethod(rawValue: methodCall.method), let sink = self.eventSink else {
                print("Unknown method invoked")
                return
            }
            method.handler.handle(methodCall: methodCall, sink: sink)
        }
    }
}

// MARK: - Event
extension PaylinkFlutterModule: FlutterStreamHandler {
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}
