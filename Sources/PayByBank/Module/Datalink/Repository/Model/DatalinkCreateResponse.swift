//
//  DatalinkCreateResponse.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkCreateResponse
/// Response model to create Datalink.
public struct DatalinkCreateResponse: Codable {
    
    /// A system assigned unique identification for the Datalink.
    /// - Note: This value is also a part of the URL.
    public let uniqueID: String?
    
    /// Unique Datalink URL that you will need to redirect PSU in order the account access consent to proceed.
    public let url: String?
    
    /// Base64 encoded QRCode image data that represents Datalink URL.
    public let qrCode: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case url
        case qrCode = "qr_code"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Datalink.
    ///     - url: Unique Datalink URL that you will need to redirect PSU in order the account access consent to proceed.
    ///     - qrCode: Base64 encoded QRCode image data that represents Datalink URL.
    public init(uniqueID: String?,
                url: String?,
                qrCode: String?) {
        self.uniqueID = uniqueID
        self.url = url
        self.qrCode = qrCode
    }
}
