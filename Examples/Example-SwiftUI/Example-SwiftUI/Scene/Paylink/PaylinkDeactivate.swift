//
//  PaylinkDeactivate.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 17.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkDeactivate: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    
    @State private var response: String? = nil
    
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
        .navigationTitle(L10n.paylinkDeactivateTitle.localizedKey)
        .sheet(item: $response) { response in
            ResponseView(response: response)
        }
    }
    
    func submit() {
        loading(true)
        PayByBank.paylink.deactivatePaylink(request: PaylinkDeleteRequest(uniqueID: uniqueID)) { result in
            loading(false)
            
            switch result {
            case .success(let model):
                response = model.jsonString
            case .failure(let error):
                response = error.localizedDescription
            }
        }
    }
}

struct PaylinkDeactivate_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkDeactivate()
    }
}
