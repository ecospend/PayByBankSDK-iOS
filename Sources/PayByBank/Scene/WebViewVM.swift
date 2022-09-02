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
    private var openURLHandler: ((URL) -> Void)?
    private var openSafariHandler: ((URL) -> Void)?
    
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
    
    func openURL(_ completion: @escaping (URL) -> Void) {
        openURLHandler = completion
    }
    
    func openSafari(_ completion: @escaping (URL) -> Void) {
        openSafariHandler = completion
    }
}

// MARK: - APIHandlerResultProtocol
extension WebViewVM: PayByBankHandlerDelegate {
    
    func handler(_ handler: PayByBankHandlerProtocol, isLoading: Bool) {
        loadingHandler?(isLoading)
    }
    
    func handler(_ handler: PayByBankHandlerProtocol, isCompleted: Bool, url: URL?) {
        
        switch isCompleted {
        case true:
            if let url = url {
                openURLHandler?(url)
            }
            dismissHandler?()
        case false:
            if let url = url {
                openSafariHandler?(url)
            }
        }
    }
}
