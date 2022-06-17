//
//  Titled.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct Titled: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        HStack {
            Text(title)
            Spacer()
            content
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
        }
    }
}

extension View {
    
    func titled(_ title: String) -> some View {
        modifier(Titled(title: title))
    }
}
