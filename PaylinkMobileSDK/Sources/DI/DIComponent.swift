//
//  DIComponent.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//

import Foundation

class DIComponent {
    
    private var current: Any?
    private let resolver: (Any?) -> Any
    let scope: DIScope
    
    init(scope: DIScope = .singleton, resolver: @escaping (Any?) -> Any) {
        self.scope = scope
        self.resolver = resolver
    }
    
    func resolve(arguments: Any?) -> Any {
        if scope == .transient {
            return resolver(arguments)
        }
        if let current = current {
            return current
        }
        current = resolver(arguments)
        return current!
    }
    
    func reset() {
        current = nil
    }
}
