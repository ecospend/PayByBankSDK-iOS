//
//  Result+.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import PayByBank

extension Result where Success: Encodable, Failure: Error {
    
    var string: String {
        switch self {
        case .success(let encodable):
            guard let result = encodable as? PayByBankResult else { return encodable.jsonString ?? "" }
            return result.status.rawValue
        case .failure(let error): return error.localizedDescription
        }
    }
}
