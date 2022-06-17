//
//  PaylinkAPIs.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

struct PaylinkAPIs: View {
    var body: some View {
        List {
            NavigationLink(L10n.paylinkOpenTitle.localizedKey, destination: PaylinkOpen())
            NavigationLink(L10n.paylinkCreateTitle.localizedKey, destination: PaylinkCreate())
        }
        .navigationBarTitle(L10n.paylinkTitle.localizedKey)
    }
}

struct PaylinkAPIs_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkAPIs()
    }
}
