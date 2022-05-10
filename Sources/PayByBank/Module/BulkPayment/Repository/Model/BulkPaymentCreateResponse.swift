//
//  BulkPaymentCreateResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 20.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - BulkPaymentCreateResponse
public struct BulkPaymentCreateResponse: Codable {
    
    /// A system assigned unique identification for the Bulk Payment Paylink.
    /// - This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Unique Bulk Payment Paylink URL that you will need to redirect PSU in order the payment to proceed.
    public let url: String?
    
    /// Base64 encoded QRCode image data that represents Bulk Payment Paylink URL.
    public let qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case url = "url"
        case qrCode = "qr_code"
    }
    
    public init(uniqueID: String?,
                url: String?,
                qrCode: String?) {
        self.uniqueID = uniqueID
        self.url = url
        self.qrCode = qrCode
    }
}
