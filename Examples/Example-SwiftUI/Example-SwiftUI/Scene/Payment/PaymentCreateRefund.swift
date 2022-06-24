//
//  PaymentCreateRefund.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 24.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaymentCreateRefund: View {
    
    @EnvironmentObject var loading: Loading
    @EnvironmentObject var toast: Toast
    
    @State private var isMainModelValid: Bool = false
    @State private var mainModel: PaymentCreateRefundMainSectionModel? = nil
    
    @State private var isRefundAccountValid: Bool = false
    @State private var refundAccount: PayByBankAccountRequest? = nil
    
    @State private var response: String? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        VStack {
            Form {
                PaymentCreateRefundMainSection(valid: $isMainModelValid, value: $mainModel)
                RefundAccountSection(valid: $isRefundAccountValid, value: $refundAccount)
            }
            Spacer()
            Button(L10n.commonSubmit.localizedKey) {
                submit()
            }
            .disabled(!isMainModelValid ||
                      !isRefundAccountValid)
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color.formBackground)
        .navigationTitle(L10n.paymentCreateRefundTitle.localizedKey)
        .safari(APIDocuments.Payment.createRefund)
        .response($response)
    }
    
    func submit() {
        guard let main = mainModel else { return }
        
        let request = PaymentCreateRefundRequest(id: main.id,
                                                 bankID: main.bankID,
                                                 amount: main.amount,
                                                 currency: main.currency,
                                                 description: main.description,
                                                 reference: main.reference,
                                                 redirectURL: main.redirectURL,
                                                 refundAccount: refundAccount)
        
        loading(true)
        
        PayByBank.payment.createRefund(request: request) { result in
            loading(false)
            response = result.string
        }
    }

}

struct PaymentCreateRefund_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCreateRefund()
    }
}
