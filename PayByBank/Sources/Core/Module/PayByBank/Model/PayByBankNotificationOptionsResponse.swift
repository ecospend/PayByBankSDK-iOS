//
//  PayByBankNotificationOptionsResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PayByBankNotificationOptionsResponse
public struct PayByBankNotificationOptionsResponse: Codable {
    
    /// Status of the sending email
    /// - Note: True if `sendEmailNotification` is true and email was sent successfully, otherwise false
    public let isEmailSent: Bool?
    
    /// Status of the sending sms
    /// - Note: True if `sendSmsNotification` is true and sms was sent successfully, otherwise false
    public let isSmsSent: Bool?
    
    public init(isEmailSent: Bool?, isSmsSent: Bool?) {
        self.isEmailSent = isEmailSent
        self.isSmsSent = isSmsSent
    }
    
    enum CodingKeys: String, CodingKey {
        case isEmailSent = "is_email_sent"
        case isSmsSent = "is_sms_sent"
    }
}
