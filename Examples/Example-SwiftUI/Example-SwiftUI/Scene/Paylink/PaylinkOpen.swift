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
    
    var body: some View {
        VStack {
            Form {
                TextField("", text: $uniqueID)
                    .titled(L10n.paylinkOpenRequestUniqueID.localized)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paylinkOpenTitle.localizedKey)
    }
    
    func submit() {
        guard let viewController = UIApplication.shared.topViewController else { return }
        loading(true)
        PayByBank.paylink.open(uniqueID: uniqueID, viewController: viewController) { result in
            loading(false)
            
            switch result {
            case .success(let result):
                switch result.status {
                case .canceled: toast(PayByBankStatus.canceled.rawValue)
                case .initiated: toast(PayByBankStatus.initiated.rawValue)
                case .redirected: toast(PayByBankStatus.redirected.rawValue)
                }
            case .failure(let error):
                toast(error.localizedDescription)
            }
        }
    }
}

struct PaylinkGet_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkOpen()
    }
}
