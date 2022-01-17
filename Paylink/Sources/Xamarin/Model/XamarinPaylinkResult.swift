//
//  XamarinPaylinkResult.swift
//  Paylink
//
//  Created by Yunus TÜR on 17.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

public class XamarinPaylinkResult: NSObject, Codable {
    
    /// Unique id value of paylink.
    @objc public let paylinkID: String
    /// Paylink URL.
    @objc public let paylinkURL: URL
    /// Payments of paylink.
    @objc public let payments: [XamarinPaylinkPaymentGetResponse]
    /// Status of paylink.
    /// - Enum: "Deleted"  "Initiated" "Completed"
    @objc public let status: String
    
    internal init(paylinkID: String,
                  paylinkURL: URL,
                  payments: [XamarinPaylinkPaymentGetResponse],
                  status: String) {
        self.paylinkID = paylinkID
        self.paylinkURL = paylinkURL
        self.payments = payments
        self.status = status
    }
}

extension PaylinkResult {
    
    internal var xamarinPaymentResult: XamarinPaylinkResult {
        return XamarinPaylinkResult(paylinkID: self.paylinkID,
                                    paylinkURL: self.paylinkURL,
                                    payments: self.payments.map { $0.xamarinPaylinkPaymentGetResponse },
                                    status: self.status.rawValue)
    }
}
