//
//  PaylinkGet.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkGet: View {
    @AppStorage(AppStorageKeys.Paylink.Get.Request.uniqueID) var uniqueID: String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField(L10n.paylinkGetRequestUniqueID.localizedKey, text: $uniqueID)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                guard let viewController = UIApplication.shared.topViewController else { return }
                PayByBank.paylink.open(uniqueID: uniqueID, viewController: viewController) { result in
                    dump(result)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle(L10n.paylinkGetTitle.localizedKey)
        
    }
}

struct PaylinkGet_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkGet()
    }
}
