//
//  WebViewVM.swift
//  PayByBank
//
//  Created by Yunus TÜR on 23.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

class WebViewVM: NSObject {
    
    var handler: PayByBankHandlerProtocol
    
    private var dismissHandler: (() -> Void)?
    private var loadingHandler: ((Bool) -> Void)?
    
    init(handler: PayByBankHandlerProtocol) {
        self.handler = handler
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
extension WebViewVM: PayByBankHandlerDelegate {
    
    func handler(_ handler: PayByBankHandlerProtocol, isLoading: Bool) {
        loadingHandler?(isLoading)
    }
    
    func handler(_ handler: PayByBankHandlerProtocol, isCompleted: Bool) {
        guard isCompleted else { return }
        dismissHandler?()
    }
}
