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
    case commonCopyAll
    // MARK: - Home
    case homeTitle
    case homeSettingsButton
    // MARK: - Settings
    case settingsTitle
    case settingsEnvironment
    case settingsEnvironmentSandbox
    case settingsEnvironmentProduction
    case settingsEnvironmentClientID
    case settingsEnvironmentClientSecret
    // MARK: - Paylink
    case paylinkTitle
    case paylinkOpenTitle
    case paylinkInitiateTitle
    case paylinkCreateTitle
    case paylinkGetTitle
    case paylinkDeactivateTitle
    // MARK: - Section
    case sectionCreditorAccount
    case sectionDebtorAccount
    case sectionPaylinkOptions
    case sectionNotificationOptions
    case sectionPaymentOptions
    case sectionPaymentOptionsPaymentReason
    case sectionLimitOptions
    // MARK: - Input
    case inputAmount
    case inputBankID
    case inputClientID
    case inputClientSecret
    case inputCreditorAccountCurrency
    case inputCreditorAccountIdentification
    case inputCreditorAccountName
    case inputCreditorAccountType
    case inputDebtorAccountCurrency
    case inputDebtorAccountIdentification
    case inputDebtorAccountName
    case inputDebtorAccountType
    case inputDescription
    case inputEnvironment
    case inputLimitOptionsAmount
    case inputLimitOptionsCount
    case inputLimitOptionsDate
    case inputMerchantID
    case inputMerchantUserID
    case inputNotificationOptionsEmail
    case inputNotificationOptionsPhoneNumber
    case inputNotificationOptionsSendEmailNotification
    case inputNotificationOptionsSendSmsNotification
    case inputPaylinkOptionsAdditionalParams
    case inputPaylinkOptionsAllowPartialPayments
    case inputPaylinkOptionsAutoRedirect
    case inputPaylinkOptionsDisableQRCode
    case inputPaylinkOptionsGenerateQRCode
    case inputPaylinkOptionsTip
    case inputPaymentOptionsForPayout
    case inputPaymentOptionsGetRefundInfo
    case inputPaymentOptionsPaymentRails
    case inputPaymentOptionsPaymentReasonContextCode
    case inputPaymentOptionsPaymentReasonDeliveryAdressAddressLine
    case inputPaymentOptionsPaymentReasonDeliveryAdressBuildingNumber
    case inputPaymentOptionsPaymentReasonDeliveryAdressCountry
    case inputPaymentOptionsPaymentReasonDeliveryAdressPostCode
    case inputPaymentOptionsPaymentReasonDeliveryAdressStreetName
    case inputPaymentOptionsPaymentReasonDeliveryAdressTownName
    case inputPaymentOptionsPaymentReasonMerchantCategoryCode
    case inputPaymentOptionsPaymentReasonMerchantCustomerIdentification
    case inputPaymentOptionsScheduledFor
    case inputRedirectURL
    case inputReference
    case inputUniqueID

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
