//
//  L10n.swift
//  Example
//
//  Created by Yunus TÜR on 11.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import SwiftUI

enum L10n {
    // MARK: - Common
    case commonSubmit
    // MARK: - Home
    case homeTitle
    // MARK: - Paylink
    case paylinkOpenTitle
    // MARK: - FrPayment
    case frPaymentOpenTitle
    // MARK: - Bulk Payment
    case bulkPaymentOpenTitle
    // MARK: - VRPlink
    case vrplinkOpenTitle
    // MARK: - Datalink
    case datalinkOpenTitle
    // MARK: - Payment
    case paymentOpenTitle
    // MARK: - Input
    case inputURL
    case inputRedirectURL
    case inputUniqueID
    case inputID
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
    
    var localized: String {
        let value = NSLocalizedString(self.key, comment: "")
        guard let arguments = self.arguments else { return value }
        return String(format: value, arguments: arguments.map { String(describing: $0) })
    }
}
