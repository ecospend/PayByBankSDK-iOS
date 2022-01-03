//
//  WebViewVM.swift
//  Paylink
//
//  Created by Yunus TÜR on 23.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

class WebViewVM {
    
    private let paylinkRepository: PaylinkRepositoryProtocol
    let model: WebViewSceneModel
    
    private var dismissCompletionHandler: (() -> Void)?
    private var loadingCompletionHandler: ((Bool) -> Void)?
    
    init(paylinkRepository: PaylinkRepositoryProtocol,
         model: WebViewSceneModel) {
        self.paylinkRepository = paylinkRepository
        self.model = model
    }
}

// MARK: - Logic
private extension WebViewVM {
    
    func handle(payments: [PaylinkPaymentGetResponse], isDeleted: Bool = false, error: Error? = nil) {
        if let error = error {
            return model.completionHandler(.failure(PaylinkError(error: error)))
        }
        
        if isDeleted {
            dismissCompletionHandler?()
            
            let result = PaylinkResult(paylinkID: model.paylinkID,
                                       paylinkURL: model.paylinkURL,
                                       payments: payments,
                                       status: .deleted)
            return model.completionHandler(.success(result))
        }
        
        if isCompleted(for: payments) {
            dismissCompletionHandler?()
            
            let result = PaylinkResult(paylinkID: model.paylinkID,
                                       paylinkURL: model.paylinkURL,
                                       payments: payments,
                                       status: .completed)
            return model.completionHandler(.success(result))
        }
        
        let result = PaylinkResult(paylinkID: model.paylinkID,
                                   paylinkURL: model.paylinkURL,
                                   payments: payments,
                                   status: .initiated)
        return model.completionHandler(.success(result))
    }
    
    func isCompleted(for payments: [PaylinkPaymentGetResponse]) -> Bool {
        return payments.contains(where: { $0.status == .completed || $0.status == .verified })
    }
}

// MARK: - Handler
extension WebViewVM {
    
    func dismiss(_ completion: @escaping () -> Void) {
        self.dismissCompletionHandler = completion
    }
    
    func loading(_ completion: @escaping (Bool) -> Void) {
        self.loadingCompletionHandler = completion
    }
}

// MARK: - Networking
extension WebViewVM {
    
    func getPayments() {
        loadingCompletionHandler?(true)
        let request = PaylinkPaymentGetRequest(paylinkID: model.paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments): self.handle(payments: payments)
            case .failure(let error): self.handle(payments: [], error: error)
            }
            
            self.loadingCompletionHandler?(false)
        }
    }
    
    func deletePaylink() {
        loadingCompletionHandler?(true)
        // Payment
        let request = PaylinkPaymentGetRequest(paylinkID: model.paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments):
                switch self.isCompleted(for: payments) {
                case true:
                    self.handle(payments: payments)
                    self.loadingCompletionHandler?(false)
                case false:
                    let request = PaylinkDeleteRequest(paylinkID: self.model.paylinkID)
                    self.paylinkRepository.deletePaylink(request: request) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success: self.handle(payments: payments, isDeleted: true)
                        case .failure(let error): self.handle(payments: [], error: error)
                        }
                        
                        self.loadingCompletionHandler?(false)
                    }
                }
            case .failure(let error):
                self.handle(payments: [], error: error)
                self.loadingCompletionHandler?(false)
            }
        }
    }
}
