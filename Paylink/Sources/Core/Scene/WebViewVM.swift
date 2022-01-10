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
    var model: WebViewSceneModel
    
    private var dismissHandler: (() -> Void)?
    private var loadingHandler: ((Bool) -> Void)?
    
    init(paylinkRepository: PaylinkRepositoryProtocol,
         model: WebViewSceneModel) {
        self.paylinkRepository = paylinkRepository
        self.model = model
    }
}

// MARK: - Handler
extension WebViewVM {
    
    func dismiss(_ completion: @escaping () -> Void) {
        dismissHandler = completion
    }
    
    func loading(_ completion: @escaping (Bool) -> Void) {
        loadingHandler = completion
    }
}

// MARK: - Logic
private extension WebViewVM {
    
    func handle(payments: [PaylinkPaymentGetResponse], isDeleted: Bool = false, error: Error? = nil) {
        if let error = error {
            model.completionHandler(.failure(PaylinkError(error: error)))
            return
        }
        
        if isDeleted {
            let result = PaylinkResult(paylinkID: model.paylinkID,
                                       paylinkURL: model.paylinkURL,
                                       payments: payments,
                                       status: .deleted)
            model.completionHandler(.success(result))
            dismiss()
            return
        }
        
        if isCompleted(for: payments) {
            let result = PaylinkResult(paylinkID: model.paylinkID,
                                       paylinkURL: model.paylinkURL,
                                       payments: payments,
                                       status: .completed)
            model.completionHandler(.success(result))
            dismiss()
            return
        }
        
        let result = PaylinkResult(paylinkID: model.paylinkID,
                                   paylinkURL: model.paylinkURL,
                                   payments: payments,
                                   status: .initiated)
        model.completionHandler(.success(result))
    }
    
    func isCompleted(for payments: [PaylinkPaymentGetResponse]) -> Bool {
        return payments.contains(where: { $0.status == .completed || $0.status == .verified })
    }
    
    func dismiss() {
        dismissHandler?()
        model.dismissHandler()
    }
}

// MARK: - Networking
extension WebViewVM {
    
    func getPayments() {
        loadingHandler?(true)
        let request = PaylinkPaymentGetRequest(paylinkID: model.paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments): self.handle(payments: payments)
            case .failure(let error): self.handle(payments: [], error: error)
            }
            
            self.loadingHandler?(false)
        }
    }
    
    func deletePaylink() {
        loadingHandler?(true)
        // Payment
        let request = PaylinkPaymentGetRequest(paylinkID: model.paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments):
                switch self.isCompleted(for: payments) {
                case true:
                    self.handle(payments: payments)
                    self.loadingHandler?(false)
                case false:
                    let request = PaylinkDeleteRequest(paylinkID: self.model.paylinkID)
                    self.paylinkRepository.deletePaylink(request: request) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success: self.handle(payments: payments, isDeleted: true)
                        case .failure(let error): self.handle(payments: [], error: error)
                        }
                        
                        self.loadingHandler?(false)
                    }
                }
            case .failure(let error):
                self.handle(payments: [], error: error)
                self.loadingHandler?(false)
            }
        }
    }
}
