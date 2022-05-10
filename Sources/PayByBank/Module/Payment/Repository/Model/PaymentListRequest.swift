//
//  PaymentListRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 21.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public struct PaymentListRequest: Codable {
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// Filter results that has been created after the `startDate` in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let startDate: String?
    
    /// Filter results that has been created before the `endDate` in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    public let endDate: String?
    
    /// Filter results by `paymentType`.
    /// - Note: Enum: "Auto" "Domestic" "DomesticScheduled" "International" "InternationalScheduled"
    public let paymentType: PaymentType?
    
    /// Paging number for query results exceeding result count limit for a single response.
    /// - Note: Default: 1
    public let page: Int?
    
    enum CodingKeys: String, CodingKey {
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case paymentType = "payment_type"
        case page = "page"
    }
    
    public init(merchantID: String?,
                merchantUserID: String?,
                startDate: String?,
                endDate: String?,
                paymentType: PaymentType?,
                page: Int?) {
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.startDate = startDate
        self.endDate = endDate
        self.paymentType = paymentType
        self.page = page
    }
}
