//
//  PaylinkFlutterMethodHandler.swift
//  Runner
//
//  Created by Berk Akkerman on 28.12.2021.
//

import Flutter

protocol PaylinkFlutterMethodHandler {
    func handle(methodCall: FlutterMethodCall, result: @escaping FlutterResult)
}
