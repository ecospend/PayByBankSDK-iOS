//
//  PaylinkResult.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 30.12.2021.
//

import Foundation

// MARK: - PaylinkResult
public struct PaylinkResult: Codable {
    /// Unique id value of paylink.
    public let paylinkID: String
    /// Paylink URL.
    public let paylinkURL: URL
    /// Payments of paylink.
    public let payments: [PaylinkPaymentGetResponse]
    /// Status of paylink.
    /// - Enum: "Deleted"  "Initiated" "Completed"
    public let status: PaylinkStatus
}

// MARK: - PaylinkStatus
public enum PaylinkStatus: String, Codable {
    case deleted = "Deleted"
    case initiated = "Initiated"
    case completed = "Completed"
}
