//
//  IamTokenRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - IamTokenRequest
/// Request model to get access token.
struct IamTokenRequest: Codable {
    
    /// Application grant types (or flows) are methods through which applications can gain Access Tokens and by which you grant limited access to your resources to another entity without exposing credentials.
    /// - Note: Default: "client_credentials"
    let grantType: String
    
    /// The Client Id is created by Ecospend when your organization is registered with us.
    /// - Note: Example: 32ddc8e8-0e9f-4952-b970-61a0b4e4ee59
    let clientID: String
    
    /// The Client Secret is a security key that your administrator should create from the Management Console. This is not visible to or accessible by the Ecospend team. Therefore, you should store it safely.
    /// - Note: Example: ZYDPLLBWSK3MVQJSIYHB1OR2JXCY0X2C5UJ2QAR2MAAIT5Q
    let clientSecret: String
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - grantType: Application grant types (or flows) are methods through which applications can gain Access Tokens and by which you grant limited access to your resources to another entity without exposing credentials.
    ///     - clientID: The Client Id is created by Ecospend when your organization is registered with us.
    ///     - clientSecret: The Client Secret is a security key that your administrator should create from the Management Console. This is not visible to or accessible by the Ecospend team. Therefore, you should store it safely.
    init(grantType: String = "client_credentials",
                clientID: String,
                clientSecret: String) {
        self.grantType = grantType
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
}
