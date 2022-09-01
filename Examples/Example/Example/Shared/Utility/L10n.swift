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
    case settingsEnvironmentAccessToken
    case settingsEnvironmentTokenType
    // MARK: - Paylink
    case paylinkTitle
    case paylinkOpenNoAuthTitle
    case paylinkOpenTitle
    case paylinkInitiateTitle
    case paylinkCreateTitle
    case paylinkGetTitle
    case paylinkDeactivateTitle
    // MARK: - FrPayment
    case frPaymentTitle
    case frPaymentOpenNoAuthTitle
    case frPaymentOpenTitle
    case frPaymentInitiateTitle
    case frPaymentCreateTitle
    case frPaymentGetTitle
    case frPaymentDeactivateTitle
    // MARK: - Bulk Payment
    case bulkPaymentTitle
    case bulkPaymentOpenNoAuthTitle
    case bulkPaymentOpenTitle
    case bulkPaymentInitiateTitle
    case bulkPaymentCreateTitle
    case bulkPaymentGetTitle
    case bulkPaymentDeactivateTitle
    // MARK: - VRPlink
    case vrplinkTitle
    case vrplinkOpenNoAuthTitle
    case vrplinkOpenTitle
    case vrplinkInitiateTitle
    case vrplinkCreateTitle
    case vrplinkGetTitle
    case vrplinkDeactivateTitle
    case vrplinkListRecordsTitle
    // MARK: - Datalink
    case datalinkTitle
    case datalinkOpenNoAuthTitle
    case datalinkOpenTitle
    case datalinkInitiateTitle
    case datalinkCreateTitle
    case datalinkGetTitle
    case datalinkDeleteTitle
    case datalinkGetOfConsentTitle
    // MARK: - Payment
    case paymentTitle
    case paymentOpenNoAuthTitle
    case paymentOpenTitle
    case paymentInitiateTitle
    case paymentInitiateRefundTitle
    case paymentCreateTitle
    case paymentListTitle
    case paymentGetTitle
    case paymentCheckURLTitle
    case paymentCreateRefundTitle
    // MARK: - Section
    case sectionCreditorAccount
    case sectionDebtorAccount
    case sectionRefundAccount
    case sectionPaylinkOptions
    case sectionNotificationOptions
    case sectionFrPaymentOptions
    case sectionPaymentOptions
    case sectionVRPOptions
    case sectionVRPlinkOptions
    case sectionVRPlinkLimitOptions
    case sectionPaymentOptionsPaymentReason
    case sectionLimitOptions
    case sectionOptions
    case sectionPayments
    case sectionDatalinkOptions
    case sectionFinancialReport
    case sectionFilters
    case sectionParameters
    case sectionAffordability
    case sectionVerification
    case sectionFinancial
    case sectionCategoryAggregation
    case sectionOutputSettings
    // MARK: - Input Settings
    case inputSettingsEnvironment
    case inputSettingsClientID
    case inputSettingsClientSecret
    // MARK: - Input Notification Options
    case inputNotificationOptionsEmail
    case inputNotificationOptionsPhoneNumber
    case inputNotificationOptionsSendEmailNotification
    case inputNotificationOptionsSendSmsNotification
    // MARK: - Input Limit Options
    case inputLimitOptionsAmount
    case inputLimitOptionsCount
    case inputLimitOptionsDate
    case inputLimitOptionsLimitExceeded
    case inputLimitOptionsCurrency
    case inputLimitOptionsSinglePaymentAmount
    case inputLimitOptionsDailyAmount
    case inputLimitOptionsWeeklyAmount
    case inputLimitOptionsFortnightlyAmount
    case inputLimitOptionsMonthlyAmount
    case inputLimitOptionsHalfYearlyAmount
    case inputLimitOptionsYearlyAmount
    case inputLimitOptionsDailyAlignment
    case inputLimitOptionsWeeklyAlignment
    case inputLimitOptionsFortnightlyAlignment
    case inputLimitOptionsMonthlyAlignment
    case inputLimitOptionsHalfYearlyAlignment
    case inputLimitOptionsYearlyAlignment
    // MARK: - Input Payment Options
    case inputPaymentOptionsForPayout
    case inputPaymentOptionsGetRefundInfo
    case inputPaymentOptionsPaymentRails
    case inputPaymentOptionsValidFrom
    case inputPaymentOptionsValidTo
    case inputPaymentOptionsScheduledFor
    case inputPaymentOptionsClientReferenceID
    case inputPaymentOptionsPsuID
    // MARK: - Input Options
    case inputOptionsFirstPaymentAmount
    case inputOptionsLastPaymentAmount
    case inputOptionsAllowPartialPayments
    case inputOptionsAutoRedirect
    case inputOptionsGenerateQRCode
    case inputOptionsDisableQRCode
    case inputOptionsDontRedirect
    case inputOptionsTip
    case inputOptionsPurpose
    case inputOptionsAllowMultipleConsent
    case inputOptionsGenerateFinancialReport
    // MARK: - Input Account
    case inputAccountCurrency
    case inputAccountIdentification
    case inputAccountName
    case inputAccountType
    case inputAccountOwnerName
    case inputAccountBic
    // MARK: - Input
    case inputAmount
    case inputBankID
    case inputType
    case inputReason
    case inputDescription
    case inputFirstPaymentDate
    case inputMerchantID
    case inputMerchantUserID
    case inputNumberOfPayments
    case inputPeriod
    case inputURL
    case inputRedirectURL
    case inputReference
    case inputStandingOrderType
    case inputAllowFrpCustomerChanges
    case inputVerifyCreditorAccount
    case inputVerifyDebtorAccount
    case inputUniqueID
    case inputFileReference
    case inputConsentEndDate
    case inputExpiryDate
    case inputPermissions
    case inputName
    case inputStartDate
    case inputEndDate
    case inputCurrency
    case inputPhoneNumbers
    case inputAddress
    case inputEmail
    case inputFinancial
    case inputDistributionPeriod
    case inputDisplayPii
    case inputConsentID
    case inputPaymentType
    case inputPage
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
