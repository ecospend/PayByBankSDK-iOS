//
//  PaylinkResult.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 30.12.2021.
//

import Foundation

// MARK: - PaylinkResult
public struct PaylinkResult: Codable {
    public let paylinkID: String
    public let paylinkURL: URL
    public let payments: [PaylinkPaymentGetResponse]
    public let status: PaylinkStatus
}

// MARK: - PaylinkStatus
public enum PaylinkStatus: String, Codable {
    case deleted = "Deleted"
    case initiated = "Initiated"
    case completed = "Completed"
}
