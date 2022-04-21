//
//  IamTokenResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

public struct IamTokenResponse: Codable {
    
    /// Access Token to be used on Ecospend calls.
    public let accessToken: String?
    
    /// Expiration time in seconds.
    /// - Default: 3600
    public let expiresIn: Int?
    
    /// Type of token provided.
    public let tokenType: String?
    
    /// Scope of the access granted.
    public let scope: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
    }
    
    public init(accessToken: String?,
                expiresIn: Int?,
                tokenType: String?,
                scope: String?) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.tokenType = tokenType
        self.scope = scope
    }
}
