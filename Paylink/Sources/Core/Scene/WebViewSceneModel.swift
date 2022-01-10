//
//  WebViewSceneModel.swift
//  Paylink
//
//  Created by Yunus TÜR on 27.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

struct WebViewSceneModel {
    let paylinkID: String
    let paylinkURL: URL
    let paylinkRedirectURL: URL
    let completionHandler: (Result<PaylinkResult, PaylinkError>) -> Void
    var dismissHandler: () -> Void
}
