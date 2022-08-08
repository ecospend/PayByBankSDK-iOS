//
//  IamTokenResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

// MARK: - IamTokenResponse
/// Response model to get access token.
struct IamTokenResponse: Codable {
    
    /// Access Token to be used on Ecospend calls.
    let accessToken: String?
    
    /// Expiration time in seconds.
    /// - Note: Default: 3600
    let expiresIn: Int?
    
    /// Type of token provided.
    let tokenType: String?
    
    /// Scope of the access granted.
    let scope: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case tokenType = "token_type"
        case scope
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - accessToken: Access Token to be used on Ecospend calls.
    ///     - expiresIn: Expiration time in seconds.
    ///     - tokenType: Type of token provided.
    ///     - scope: Scope of the access granted.
    init(accessToken: String?,
                expiresIn: Int?,
                tokenType: String?,
                scope: String?) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.tokenType = tokenType
        self.scope = scope
    }
}
