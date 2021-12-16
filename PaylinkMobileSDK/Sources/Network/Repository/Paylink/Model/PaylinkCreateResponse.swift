//
//  PaylinkCreateResponse.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//

import Foundation

public struct PaylinkCreateResponse: Codable {
    
    /// A system assigned unique identification for the Paylink.
    /// - This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Unique Paylink URL that you will need to redirect PSU in order the payment to proceed.
    public let paylinkURL: String?
    
    /// Base64 encoded QRCode image data that represents Paylink URL.
    public let qrCode: String?
    
    public init(uniqueID: String?,
                paylinkURL: String?,
                qrCode: String?) {
        self.uniqueID = uniqueID
        self.paylinkURL = paylinkURL
        self.qrCode = qrCode
    }
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case paylinkURL = "url"
        case qrCode = "qr_code"
    }
}
