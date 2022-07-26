//
//  PrimaryButton.swift
//  Example
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .padding()
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color.blue.cornerRadius(8))
        .opacity((configuration.isPressed || !isEnabled) ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == PrimaryButton {
    
    static var primary: PrimaryButton {
        PrimaryButton()
    }
}
