//
//  IamTokenRequest.swift.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

public struct IamTokenRequest: Codable {
    
    /// - Default: "client_credentials"
    public let grantType: String
    
    /// - Example: 32ddc8e8-0e9f-4952-b970-61a0b4e4ee59
    public let clientID: String
    
    /// - Example: ZYDPLLBWSK3MVQJSIYHB1OR2JXCY0X2C5UJ2QAR2MAAIT5Q
    public let clientSecret: String
    
    public init(grantType: String = "client_credentials",
                clientID: String,
                clientSecret: String) {
        self.grantType = grantType
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
}
