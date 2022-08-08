//
//  PaymentListResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentListResponse
/// Response model to list Payments.
public struct PaymentListResponse: Codable {
    
    /// List of Payments.
    public let data: [PaymentGetResponse]?
    
    /// Meta information.
    public let meta: PaymentMetaResponse?
    
    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - data: List of Payments.
    ///     - meta: Meta information.
    public init(data: [PaymentGetResponse]?, meta: PaymentMetaResponse?) {
        self.data = data
        self.meta = meta
    }
}

// MARK: - PaymentMetaResponse
/// Meta information to list Payments.
public struct PaymentMetaResponse: Codable {
    
    /// Count of total items.
    public let totalCount: Int?
    
    /// Count of total pages.
    public let totalPages: Int?
    
    /// Current page number.
    public let currentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - totalCount: Count of total items.
    ///     - totalPages: Count of total pages.
    ///     - currentPage: Current page number.
    public init(totalCount: Int?,
                totalPages: Int?,
                currentPage: Int?) {
        self.totalCount = totalCount
        self.totalPages = totalPages
        self.currentPage = currentPage
    }
}
