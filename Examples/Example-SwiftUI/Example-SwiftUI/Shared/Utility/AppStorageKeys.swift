//
//  AppStorageKeys.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum AppStorageKeys: String {
    // MARK: - Input Settings
    case settingsEnvironment
    case settingsClientID
    case settingsClientSecret
    // MARK: - Input Notification Options
    case notificationOptionsEmail
    case notificationOptionsPhoneNumber
    case notificationOptionsSendEmailNotification
    case notificationOptionsSendSmsNotification
    // MARK: - Input Limit Options
    case limitOptionsAmount
    case limitOptionsCount
    case limitOptionsDate
    case limitOptionsLimitExceeded
    case limitOptionsCurrency
    case limitOptionsSinglePaymentAmount
    case limitOptionsDailyAmount
    case limitOptionsWeeklyAmount
    case limitOptionsFortnightlyAmount
    case limitOptionsMonthlyAmount
    case limitOptionsHalfYearlyAmount
    case limitOptionsYearlyAmount
    case limitOptionsDailyAlignment
    case limitOptionsWeeklyAlignment
    case limitOptionsFortnightlyAlignment
    case limitOptionsMonthlyAlignment
    case limitOptionsHalfYearlyAlignment
    case limitOptionsYearlyAlignment
    // MARK: - Input Payment Options
    case paymentOptionsForPayout
    case paymentOptionsGetRefundInfo
    case paymentOptionsPaymentRails
    case paymentOptionsValidFrom
    case paymentOptionsValidTo
    case paymentOptionsScheduledFor
    case paymentOptionsClientReferenceID
    case paymentOptionsPsuID
    // MARK: - Input Options
    case optionsFirstPaymentAmount
    case optionsLastPaymentAmount
    case optionsAllowPartialPayments
    case optionsAutoRedirect
    case optionsGenerateQRCode
    case optionsDisableQRCode
    case optionsDontRedirect
    case optionsTip
    case optionsPurpose
    case optionsAllowMultipleConsent
    case optionsGenerateFinancialReport
    // MARK: - Input Account
    case accountCurrency
    case accountIdentification
    case accountName
    case accountType
    case accountOwnerName
    case accountBic
    // MARK: - Input
    case amount
    case bankID
    case type
    case reason
    case description
    case firstPaymentDate
    case merchantID
    case merchantUserID
    case numberOfPayments
    case period
    case redirectURL
    case reference
    case standingOrderType
    case allowFrpCustomerChanges
    case verifyCreditorAccount
    case verifyDebtorAccount
    case uniqueID
    case fileReference
    case consentEndDate
    case expiryDate
    case permissions
    case name
    case startDate
    case endDate
    case currency
    case phoneNumbers
    case address
    case email
    case financial
    case distributionPeriod
    case displayPii
    case consentID
    case paymentType
    case page
    case id
}
