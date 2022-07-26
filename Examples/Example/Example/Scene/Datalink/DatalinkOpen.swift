//
//  DatalinkOpen.swift
//  Example
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkOpen: View {
    
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
            .disabled(uniqueID.isBlank)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.datalinkOpenTitle.localizedKey)
        .safari(APIDocuments.Datalink.get)
    }
    
    func submit() {
        hideKeyboard()
        guard let viewController = UIApplication.shared.topViewController else { return }
        
        loading(true)
        PayByBank.datalink.open(uniqueID: uniqueID, viewController: viewController) { result in
            loading(false)
            toast(result.string)
        }
    }
}

struct DatalinkOpen_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkOpen()
    }
}
