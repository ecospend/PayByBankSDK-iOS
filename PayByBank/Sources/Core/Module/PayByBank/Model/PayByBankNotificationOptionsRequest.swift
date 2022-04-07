//
//  PayByBankNotificationOptionsRequest.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankNotificationOptionsRequest
public struct PayByBankNotificationOptionsRequest: Codable {
    
    /// Optional parameter for Gateway to send an email notification to the PSU with the Paylink URL.
    /// - Note: Defaults to false.
    public let sendEmailNotification: Bool?
    
    /// The email address that the email notification will be sent to.
    /// - Warning: This field is mandatory if `sendEmailNotification` is true.
    public let email: String?
    
    /// Optional parameter for Gateway to send an SMS notification to the PSU with the Paylink URL.
    /// - Note: Defaults to false.
    public let sendSMSNotification: Bool?
    
    /// The phone number (including the country dial-in code) that the SMS notification will be sent to.
    /// - Warning: This field is mandatory if `sendSMSNotification` is true.
    public let phoneNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case sendEmailNotification = "send_email_notification"
        case email
        case sendSMSNotification = "send_sms_notification"
        case phoneNumber = "phone_number"
    }
}
