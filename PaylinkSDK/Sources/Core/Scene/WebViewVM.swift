//
//  WebViewVM.swift
//  PaylinkSDK
//
//  Created by Yunus TÜR on 23.12.2021.
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
    
    @discardableResult
    func checkPayments(for result: Result<[PaylinkPaymentGetResponse], Error>) -> Bool {
        model.paymentsCompletionHandler(result)
        if case .success(let payments) = result,
            payments.contains(where: { $0.status == .completed || $0.status == .verified }) {
            dismissCompletionHandler?()
            return true
        }
        return false
    }
    
    func checkDelele(for result: Result<Bool, Error>, isDismissed: Bool) {
        if case .failure(let error) = result {
            model.paymentsCompletionHandler(.failure(error))
        }
        
        if !isDismissed {
            dismissCompletionHandler?()
        }
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
            self.checkPayments(for: result)
            self.loadingCompletionHandler?(false)
        }
    }
    
    func deletePaylink() {
        loadingCompletionHandler?(true)
        // Payment
        let request = PaylinkPaymentGetRequest(paylinkID: model.paylinkID)
        paylinkRepository.getPayments(request: request) { [weak self] result in
            guard let self = self else { return }
            let isDismissed = self.checkPayments(for: result)
            
            // Delete
            let request = PaylinkDeleteRequest(paylinkID: self.model.paylinkID)
            self.paylinkRepository.deletePaylink(request: request) { [weak self] result in
                guard let self = self else { return }
                self.checkDelele(for: result, isDismissed: isDismissed)
                self.loadingCompletionHandler?(false)
            }
        }
    }
}
