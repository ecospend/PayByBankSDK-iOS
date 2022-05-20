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
    
    @AppStorage(AppStorageKeys.Paylink.Open.Request.uniqueID) var uniqueID: String = ""
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text(L10n.paylinkOpenRequestUniqueID.localizedKey)
                    TextField("", text: $uniqueID)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            Button {
                submit()
            } label: {
                Text(L10n.commonSubmit.localizedKey)
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
            }
            .padding()
            .buttonStyle(.borderedProminent)
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
