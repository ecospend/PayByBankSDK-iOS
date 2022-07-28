//
//  JSONEncoderStrategy.swift
//  PayByBank
//
//  Created by Yunus TÜR on 28.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol JSONEncoderStrategy {
    var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy { get }
}

extension JSONEncoderStrategy {
    
    var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dateEncodingStrategy
        return encoder
    }
}
