//
//  DatalinkCreateResponse.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkCreateResponse
struct DatalinkCreateResponse: Codable {
    
    /// A system assigned unique identification for the Datalink.
    /// - This value is also a part of the URL.
    let uniqueID: String?
    
    /// Unique Datalink URL that you will need to redirect PSU in order the account access consent to proceed.
    let url: String?
    
    /// Base64 encoded QRCode image data that represents Datalink URL.
    let qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case url
        case qrCode = "qr_code"
    }
}
