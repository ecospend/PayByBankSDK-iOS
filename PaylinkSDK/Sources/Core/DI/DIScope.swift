//
//  DIScope.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//

import Foundation

protocol DIScopeProtocol {
}

enum DIScope: DIScopeProtocol {
    case transient
    case singleton
}
