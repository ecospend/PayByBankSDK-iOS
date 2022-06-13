//
//  Titled.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct Titled: ViewModifier {
    let title: String?
    
    func body(content: Content) -> some View {
        HStack {
            if let title = title {
                Text(title)
            }
            content
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
        }
    }
}

extension TextField {
    func titled(_ title: String?) -> some View {
        modifier(Titled(title: title))
    }
}
