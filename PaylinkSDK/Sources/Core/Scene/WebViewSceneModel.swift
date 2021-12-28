//
//  WebViewSceneModel.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 27.12.2021.
//

import Foundation

struct WebViewSceneModel {
    let paylinkID: String
    let paylinkURL: URL
    let paylinkRedirectURL: URL
    let paymentsCompletionHandler: (Result<[PaylinkPaymentGetResponse], Error>) -> Void
}
