//
//  PaymentListResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaymentListResponse
public struct PaymentListResponse: Codable {
    public let data: [PaymentGetResponse]?
    public let meta: PaymentMetaResponse?
    
    enum CodingKeys: String, CodingKey {
        case data
        case meta
    }
    
    public init(data: [PaymentGetResponse]?, meta: PaymentMetaResponse?) {
        self.data = data
        self.meta = meta
    }
}

// MARK: - PaymentMetaResponse
public struct PaymentMetaResponse: Codable {
    public let totalCount: Int?
    public let totalPages: Int?
    public let currentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
    
    public init(totalCount: Int?,
                totalPages: Int?,
                currentPage: Int?) {
        self.totalCount = totalCount
        self.totalPages = totalPages
        self.currentPage = currentPage
    }
}
