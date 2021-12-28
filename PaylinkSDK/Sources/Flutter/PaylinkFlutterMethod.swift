//
//  PaylinkFlutterMethod.swift
//  Runner
//
//  Created by Berk Akkerman on 28.12.2021.
//

enum PaylinkFlutterMethod: String {
    
    case configure
    case open
    case initiate
    
    var handler: PaylinkFlutterMethodHandler {
        switch self {
        case .configure: return PaylinkConfigureMethodFlutterHandler() as PaylinkFlutterMethodHandler
        case .open: return PaylinkOpenMethodFlutterHandler() as PaylinkFlutterMethodHandler
        case .initiate: return PaylinkInitiateMethodFlutterHandler() as PaylinkFlutterMethodHandler
        }
    }
}
