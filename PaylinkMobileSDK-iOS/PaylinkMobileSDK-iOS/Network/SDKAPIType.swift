//
//  SDKAPIType.swift
//  SpeedyPaySDK
//
//  Created by Berk Akkerman on 13.12.2021.
//

import Foundation

protocol SDKAPIType {
    var scheme: String { get }
    var host: String { get }
    var headers: [String: String] { get }
    var versionPrefix: String { get }
    var method: SDKHTTPMethod { get }
    var endpoint: String { get }
    var body: [String: Any]? { get }
}
