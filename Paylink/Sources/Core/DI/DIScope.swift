//
//  DIScope.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 14.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

protocol DIScopeProtocol {
}

enum DIScope: DIScopeProtocol {
    case transient
    case singleton
}
