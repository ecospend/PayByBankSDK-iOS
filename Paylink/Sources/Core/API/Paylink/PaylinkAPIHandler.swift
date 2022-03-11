//
//  PaylinkAPIHandler.swift
//  Paylink
//
//  Created by Yunus TÜR on 11.03.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import WebKit

class PaylinkAPIHandler: APIHandlerProtocol {
    
    let uniqueID: String
    let webViewURL: URL
    let redirectURL: URL
    let completionHandler: (Result<PaylinkResult, PaylinkError>) -> Void
    weak var delegate: APIHandlerWebViewProtocol?
    
    private let paylinkRepository: PaylinkRepositoryProtocol
    
    init(uniqueID: String,
         webViewURL: URL,
         redirectURL: URL,
         paylinkRepository: PaylinkRepositoryProtocol,
         completionHandler: @escaping (Result<PaylinkResult, PaylinkError>) -> Void) {
        self.uniqueID = uniqueID
        self.webViewURL = webViewURL
        self.redirectURL = redirectURL
        self.completionHandler = completionHandler
        self.paylinkRepository = paylinkRepository
    }
}

// MARK: - APIHandlerProtocol
extension PaylinkAPIHandler {
    
    func getWebViewDecision(url: URL?) -> WKNavigationActionPolicy {
        guard let url = url else { return .allow }
        
        switch url.host {
        case redirectURL.host:
            if let params = url.queryParameters,
               params["error"] == "user_canceled",
               params["paylink_id"] == uniqueID {
                deleteLink()
                return .cancel
            } else {
                return .cancel
            }
        case webViewURL.host:
            return .allow
        default:
            UIApplication.shared.open(url)
            return .cancel
        }
    }
    
    func checkStatus() {
        delegate?.handler(self, isLoading: true)
        let request = PaylinkPaymentGetRequest(paylinkID: uniqueID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments): self.handle(payments: payments)
            case .failure(let error): self.handle(payments: [], error: error)
            }
            
            self.delegate?.handler(self, isLoading: false)
        }
    }
    
    func deleteLink() {
        delegate?.handler(self, isLoading: true)
        let request = PaylinkPaymentGetRequest(paylinkID: uniqueID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let payments):
                switch self.isCompleted(for: payments) {
                case true:
                    self.handle(payments: payments)
                    self.delegate?.handler(self, isLoading: false)
                case false:
                    let request = PaylinkDeleteRequest(paylinkID: self.uniqueID)
                    self.paylinkRepository.deletePaylink(request: request) { [weak self] result in
                        guard let self = self else { return }
                        
                        switch result {
                        case .success: self.handle(payments: payments, isDeleted: true)
                        case .failure(let error): self.handle(payments: [], error: error)
                        }
                        
                        self.delegate?.handler(self, isLoading: false)
                    }
                }
            case .failure(let error):
                self.handle(payments: [], error: error)
                self.delegate?.handler(self, isLoading: false)
            }
        }
    }
}

// MARK: - Logic
private extension PaylinkAPIHandler {
    
    func handle(payments: [PaylinkPaymentGetResponse], isDeleted: Bool = false, error: Error? = nil) {
        if let error = error {
            completionHandler(.failure(PaylinkError(error: error)))
            return
        }
        
        if isDeleted {
            let result = PaylinkResult(uniqueID: uniqueID, status: .deleted)
            delegate?.handler(self, isCompleted: true)
            completionHandler(.success(result))
            return
        }
        
        if isCompleted(for: payments) {
            let result = PaylinkResult(uniqueID: uniqueID, status: .completed)
            delegate?.handler(self, isCompleted: true)
            completionHandler(.success(result))
            return
        }
        
        let result = PaylinkResult(uniqueID: uniqueID, status: .initiated)
        completionHandler(.success(result))
    }
    
    func isCompleted(for payments: [PaylinkPaymentGetResponse]) -> Bool {
        return payments.contains(where: { $0.status == .completed || $0.status == .verified })
    }
}
