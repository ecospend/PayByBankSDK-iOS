//
//  JSONDecoderStrategy.swift
//  PayByBank
//
//  Created by Yunus TÜR on 28.07.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

protocol JSONDecoderStrategy {
    var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy { get }
}

extension JSONDecoderStrategy {
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return decoder
    }
}
