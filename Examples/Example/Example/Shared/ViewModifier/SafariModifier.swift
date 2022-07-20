//
//  SafariModifier.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct SafariModifier: ViewModifier {
    
    @State private(set) var urlString: String
    @State private var url: URL? = nil
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                Button {
                    url = URL(string: urlString)
                } label: {
                    Image(systemName: "safari")
                }
            }
            .sheet(item: $url) { url in
                SafariView(url: url)
                    .ignoresSafeArea()
            }
    }
}

extension View {
    
    func safari(_ urlString: String) -> some View {
        modifier(SafariModifier(urlString: urlString))
    }
}
