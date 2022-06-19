//
//  ResponseView.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 17.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct ResponseView: View {
    
    private let response: String
    
    init(response: String) {
        self.response = response
        
        UITextView.appearance().textContainerInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Capsule()
                    .fill(Color.secondary)
                    .opacity(0.5)
                    .frame(width: 35, height: 5)
                    .padding()
                Spacer()
            }
            VStack {
                TextEditor(text: .constant(response))
                    .colorMultiply(Color.formBackground)
                    .padding(.top)
                    .padding(.top)
                Spacer()
                Button(L10n.commonCopyAll.localized) {
                    UIPasteboard.general.string = response
                }
                .buttonStyle(.primary)
                .padding()
            }
        }
        .background(Color.formBackground)
    }
}

struct ResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseView(response: """
            {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        {
                "unique_id" : "AW3bxH3rGQ",
                "url" : "https://paylinkv2.sb.ecospend.com/?uid=AW3bxH3rGQ&ch=3",
                "qr_code" : ""
            }
        """
        )
    }
}
