//
//  WebViewVM.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 23.12.2021.
//

import Foundation

class WebViewVM {
    
    private let paylinkRepository: PaylinkRepositoryProtocol
    private let paylinkID: String
    private let paymentsCompletion: ((Result<[PaylinkPaymentGetResponse], Error>) -> Void)
    
    init(paylinkRepository: PaylinkRepositoryProtocol,
         paylinkID: String,
         paymentsCompletion: @escaping ((Result<[PaylinkPaymentGetResponse], Error>) -> Void)) {
        self.paylinkRepository = paylinkRepository
        self.paylinkID = paylinkID
        self.paymentsCompletion = paymentsCompletion
    }
}

// MARK: - Networking
extension WebViewVM {
    
    func getPayments() {
        let request = PaylinkPaymentGetRequest(paylinkID: paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            self.paymentsCompletion(result)
        }
    }
}

