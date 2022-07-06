//
//  VRPlinkDeactivate.swift
//  Example
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkDeactivate: View {
    
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
            .disabled(uniqueID.isBlank)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.vrplinkDeactivateTitle.localizedKey)
        .safari(APIDocuments.VRPlink.deactivate)
        .response($response)
    }
    
    func submit() {
        hideKeyboard()
        loading(true)
        PayByBank.vrplink.deactivateVRPlink(request: VRPlinkDeleteRequest(uniqueID: uniqueID)) { result in
            loading(false)
            response = result.string
        }
    }
}

struct VRPlinkDeactivate_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkDeactivate()
    }
}
