//
//  DatalinkDeleteRequest.swift
//  Paylink
//
//  Created by Berk Akkerman on 9.03.2022.
//

import Foundation

// MARK: - DatalinkDeleteRequest
/// Request model to delete Datalink.
public struct DatalinkDeleteRequest: Codable {
    
    /// A system assigned unique identification for the Datalink.
    public let uniqueID: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
    }
    
    /// Creates an instance from the specified parameters.
    ///
    /// - Parameters:
    ///     - uniqueID: A system assigned unique identification for the Datalink.
    public init(uniqueID: String) {
        self.uniqueID = uniqueID
    }
}
