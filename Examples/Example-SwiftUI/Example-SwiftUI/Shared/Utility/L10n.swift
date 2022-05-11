//
//  L10n.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import SwiftUI

enum L10n {
    // MARK: - Common
    case commonSubmit
    case homeTitle
    case homeConfigureButton
    // MARK: - Configuration
    case configurationTitle
    case ConfigurationEnvironment
    case configurationEnvironmentSandbox
    case configurationEnvironmentProduction
    case configurationEnvironmentClientID
    case configurationEnvironmentClientSecret
    // MARK: - Paylink
    case paylinkTitle
    // MARK: - Paylink Get
    case paylinkGetTitle
    case paylinkGetRequestUniqueID
}

// MARK: - Logic
extension L10n {
    
    var key: String {
        let key = String("\(self)".split(separator: "(").first ?? "")
        return key.prefix(1).uppercased() + key.dropFirst()
    }
    
    var localizedKey: LocalizedStringKey {
        LocalizedStringKey(key)
    }
    
    var arguments: [CVarArg]? {
        switch self {
        // case .example(let anything): return [anything].toCVarArgs()
        default: return nil
        }
    }
    
    var localized: String? {
        let value = NSLocalizedString(self.key, comment: "")
        guard let arguments = self.arguments else { return value }
        return String(format: value, arguments: arguments.map { String(describing: $0) })
    }
}
