//
//  FrPaymentCreateResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - FrPaymentCreateResponse
public struct FrPaymentCreateResponse: Codable {
    
    /// A system assigned unique identification for the FrPayment.
    /// - This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Unique FrPayment URL that you will need to redirect PSU in order the payment to proceed.
    public let paylinkURL: String?
    
    /// Base64 encoded QRCode image data that represents FrPayment URL.
    public let qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case paylinkURL = "url"
        case qrCode = "qr_code"
    }
}
