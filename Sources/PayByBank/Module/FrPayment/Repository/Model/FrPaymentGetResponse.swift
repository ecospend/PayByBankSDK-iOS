//
//  FrPaymentGetResponse.swift
//  PayByBank
//
//  Created by Yunus TÜR on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

// MARK: - PaylinkGetResponse
public struct FrPaymentGetResponse: Codable {
    
    /// Unique id value of FrPayment.
    public let uniqueID: String?
    
    /// FrPayment amount in decimal format.
    public let amount: Decimal?
    
    // Payment reference that will be displayed on the bank statement. 18 characters MAX.
    public let reference: String?
    
    /// Description for the payment. 255 character MAX.
    public let description: String?
    
    /// The URL of the Tenant that the PSU will be redirected at the end of the FrPayment journey.
    /// This URL must be registered by your Admin on the Ecospend Management Console, prior to being used in the API calls.
    public let redirectURL: String?
    
    /// The URL to open bank selection screen
    public let url: String?
    
    /// Unique identification string assigned to the bank by our system.
    /// If value is set, FrPayment will not display any UI and execute an instant redirect to the debtor's banking system.
    /// If value is not set, FrPayment will display the PSU a bank selection screen.
    public let bankID: String?
    
    /// If you are providing our Payment service to your own business clients (merchants), then you should set the Id of your merchant.
    public let merchantID: String?
    
    /// The Id of the end-user.
    /// If you are providing this service directly to the end-users, then you can assign that Id to this parameter.
    /// If you are providing this service to businesses, then you should assign the Id of that merchant’s user.
    public let merchantUserID: String?
    
    /// It is the account that will receive the payment.
    public let creditorAccount: PayByBankAccountResponse?
    
    /// It is the account from which the payment will be taken.
    public let debtorAccount: PayByBankAccountResponse?
    
    /// The FrPayment Options model
    public let frPaymentOptions: FrPaymentOptionsResponse?
    
    /// Date and time of the first payment in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format.
    /// - Warning: This date must be a work day.
    public let firstPaymentDate: Date?
    
    /// Number of total payments being set with this standing order.
    public let numberOfPayments: Int?
    
    /// Period of FrPayment
    /// - Note: Enum: "Weekly" "Monthly" "Yearly"
    public let period: FrPaymentPeriod?
    
    /// The user has the right to change the FrPayment related additional parameters
    /// - Note: Defaults to false.
    public let allowFrpCustomerChanges: Bool?
    
    enum CodingKeys: String, CodingKey {
        case uniqueID = "unique_id"
        case amount, reference, description
        case redirectURL = "redirect_url"
        case url
        case bankID = "bank_id"
        case merchantID = "merchant_id"
        case merchantUserID = "merchant_user_id"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case frPaymentOptions = "fr_payment_options"
        case firstPaymentDate = "first_payment_date"
        case numberOfPayments = "number_of_payments"
        case period
        case allowFrpCustomerChanges = "allowFrpCustomerChanges"
    }
    
    public init(uniqueID: String?,
                amount: Decimal?,
                reference: String?,
                description: String?,
                redirectURL: String?,
                url: String?,
                bankID: String?,
                merchantID: String?,
                merchantUserID: String?,
                creditorAccount: PayByBankAccountResponse?,
                debtorAccount: PayByBankAccountResponse?,
                frPaymentOptions: FrPaymentOptionsResponse?,
                firstPaymentDate: Date?,
                numberOfPayments: Int?,
                period: FrPaymentPeriod?,
                allowFrpCustomerChanges: Bool?) {
        self.uniqueID = uniqueID
        self.amount = amount
        self.reference = reference
        self.description = description
        self.redirectURL = redirectURL
        self.url = url
        self.bankID = bankID
        self.merchantID = merchantID
        self.merchantUserID = merchantUserID
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.frPaymentOptions = frPaymentOptions
        self.firstPaymentDate = firstPaymentDate
        self.numberOfPayments = numberOfPayments
        self.period = period
        self.allowFrpCustomerChanges = allowFrpCustomerChanges
    }
}

// MARK: - FrPaymentOptionsResponse
public struct FrPaymentOptionsResponse: Codable {
    
    /// Client id of the API consumer
    public let clientID: String?
    
    /// Tenant id of the API consumer
    public let tenantID: String?
    
    /// Set true, if you would like to get back the debtor's account information that the payment is made from.
    /// - Note: If not provided, defaults to 'true'.
    public let getRefundInfo: Bool?
    
    /// Amount of first payment
    public let firstPaymentAmount: Decimal?
    
    /// Amount of last payment
    public let lastPaymentAmount: Decimal?
    
    /// Disables QR Code component on FrPayment
    public let disableQrCode: Bool?
    
    /// Customizes editable option of fields
    public let editableFields: FrPaymentEditableField?
    
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case tenantID = "tenant_id"
        case getRefundInfo = "get_refund_info"
        case firstPaymentAmount = "first_payment_amount"
        case lastPaymentAmount = "last_payment_amount"
        case disableQrCode = "disable_qr_code"
        case editableFields = "editable_fields"
    }
    
    public init(clientID: String?,
                tenantID: String?,
                getRefundInfo: Bool?,
                firstPaymentAmount: Decimal?,
                lastPaymentAmount: Decimal?,
                disableQrCode: Bool?,
                editableFields: FrPaymentEditableField?) {
        self.clientID = clientID
        self.tenantID = tenantID
        self.getRefundInfo = getRefundInfo
        self.firstPaymentAmount = firstPaymentAmount
        self.lastPaymentAmount = lastPaymentAmount
        self.disableQrCode = disableQrCode
        self.editableFields = editableFields
    }
}
