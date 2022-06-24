//
//  DatalinkDelete.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkDelete: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @AppStorage(Self.storage(key: .uniqueID)) var uniqueID: String = ""
    
    @State private var response: String? = nil
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
        .navigationTitle(L10n.datalinkDeleteTitle.localizedKey)
        .safari(APIDocuments.Datalink.delete)
        .response($response)
    }
    
    func submit() {
        loading(true)
        PayByBank.datalink.deleteDatalink(request: DatalinkDeleteRequest(uniqueID: uniqueID)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct DatalinkDelete_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkDelete()
    }
}
