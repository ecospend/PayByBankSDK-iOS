//
//  PaylinkOpen.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkOpen: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $uniqueID)
                    .titled(L10n.inputUniqueID.localized.required)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .disabled(uniqueID.isEmpty)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paylinkOpenTitle.localizedKey)
        .safari(APIDocuments.Paylink.create)
    }
    
    func submit() {
        guard let viewController = UIApplication.shared.topViewController else { return }
        loading(true)
        PayByBank.paylink.open(uniqueID: uniqueID, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct PaylinkOpen_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkOpen()
    }
}
