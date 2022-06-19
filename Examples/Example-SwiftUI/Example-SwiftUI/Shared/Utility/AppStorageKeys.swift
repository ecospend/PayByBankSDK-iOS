//
//  AppStorageKeys.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 13.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

enum AppStorageKeys: String {
    case amount
    case bankID
    case clientID
    case clientSecret
    case creditorAccountCurrency
    case creditorAccountIdentification
    case creditorAccountName
    case creditorAccountType
    case debtorAccountCurrency
    case debtorAccountIdentification
    case debtorAccountName
    case debtorAccountType
    case description
    case environment
    case limitOptionsAmount
    case limitOptionsCount
    case limitOptionsDate
    case merchantID
    case merchantUserID
    case notificationOptionsEmail
    case notificationOptionsPhoneNumber
    case notificationOptionsSendEmailNotification
    case notificationOptionsSendSmsNotification
    case paylinkOptionsAdditionalParams
    case paylinkOptionsAllowPartialPayments
    case paylinkOptionsAutoRedirect
    case paylinkOptionsDisableQRCode
    case paylinkOptionsGenerateQRCode
    case paylinkOptionsTip
    case paymentOptionsForPayout
    case paymentOptionsGetRefundInfo
    case paymentOptionsPaymentRails
    case paymentOptionsPaymentReasonContextCode
    case paymentOptionsPaymentReasonDeliveryAdressAddressLine
    case paymentOptionsPaymentReasonDeliveryAdressBuildingNumber
    case paymentOptionsPaymentReasonDeliveryAdressCountry
    case paymentOptionsPaymentReasonDeliveryAdressPostCode
    case paymentOptionsPaymentReasonDeliveryAdressStreetName
    case paymentOptionsPaymentReasonDeliveryAdressTownName
    case paymentOptionsPaymentReasonMerchantCategoryCode
    case paymentOptionsPaymentReasonMerchantCustomerIdentification
    case paymentOptionsScheduledFor
    case redirectURL
    case reference
    case uniqueID
}
