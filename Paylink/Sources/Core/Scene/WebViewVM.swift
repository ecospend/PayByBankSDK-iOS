//
//  WebViewVM.swift
//  Paylink
//
//  Created by Yunus TÜR on 23.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

class WebViewVM: NSObject {
    
    private let paylinkRepository: PaylinkRepositoryProtocol
    var handler: APIHandlerProtocol
    
    private var dismissHandler: (() -> Void)?
    private var loadingHandler: ((Bool) -> Void)?
    
    init(handler: APIHandlerProtocol,
         paylinkRepository: PaylinkRepositoryProtocol) {
        self.handler = handler
        self.paylinkRepository = paylinkRepository
        super.init()
        //
        self.handler.delegate = self
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

// MARK: - APIHandlerResultProtocol
extension WebViewVM: APIHandlerDelegate {
    
    func handler(_ handler: APIHandlerProtocol, isLoading: Bool) {
        loadingHandler?(isLoading)
    }
    
    func handler(_ handler: APIHandlerProtocol, isCompleted: Bool) {
        guard isCompleted else { return }
        dismissHandler?()
    }
}
