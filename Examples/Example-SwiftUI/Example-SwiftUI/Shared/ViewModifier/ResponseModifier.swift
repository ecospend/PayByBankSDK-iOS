//
//  ResponseModifier.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct ResponseModifier: ViewModifier {
    
    @Binding private(set) var response: String?
    
    func body(content: Content) -> some View {
        content
            .sheet(item: $response) { response in
                ResponseView(response: response)
            }
    }
}

extension View {
    
    func response(_ response: Binding<String?>) -> some View {
        modifier(ResponseModifier(response: response))
    }
}
