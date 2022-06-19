//
//  APIDocuments.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 19.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

struct APIDocuments {
    
    struct Paylink {
        static let base = "https://docs.ecospend.com/api/paylink/V2/#tag/Paylink-API"
        static let create = "\(base)/paths/~1api~1v2.0~1paylinks/post"
        static let get = "\(base)/paths/~1api~1v2.0~1paylinks~1%7BpaylinkId%7D/get"
        static let deactivate = "\(base)/paths/~1api~1v2.0~1paylinks~1%7BpaylinkId%7D/delete"
    }
}
