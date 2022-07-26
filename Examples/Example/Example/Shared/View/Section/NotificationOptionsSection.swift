//
//  NotificationOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 15.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct NotificationOptionsSection: View {
    
    @AppStorage(Self.storage(key: .notificationOptionsSendEmailNotification)) private var sendEmailNotification: Bool = false
    @AppStorage(Self.storage(key: .notificationOptionsEmail)) private var email: String = ""
    @AppStorage(Self.storage(key: .notificationOptionsSendSmsNotification)) private var sendSmsNotification: Bool = false
    @AppStorage(Self.storage(key: .notificationOptionsPhoneNumber)) private var phoneNumber: String = ""
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PayByBankNotificationOptionsRequest?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputNotificationOptionsSendEmailNotification.localized, isOn: $sendEmailNotification)
                    TextField("", text: $email)
                        .titled(sendEmailNotification ?
                                L10n.inputNotificationOptionsEmail.localized.required :
                                    L10n.inputNotificationOptionsEmail.localized)
                    Toggle(L10n.inputNotificationOptionsSendSmsNotification.localized, isOn: $sendSmsNotification)
                    TextField("", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .titled(sendSmsNotification ?
                                L10n.inputNotificationOptionsPhoneNumber.localized.required :
                                    L10n.inputNotificationOptionsPhoneNumber.localized)
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: sendEmailNotification) { _ in validate() }
        .onChange(of: email) { _ in validate() }
        .onChange(of: sendSmsNotification) { _ in validate() }
        .onChange(of: phoneNumber) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionNotificationOptions.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = {
            guard enabled else { return true }
            if sendEmailNotification, !email.isEmail { return false }
            if sendSmsNotification, !phoneNumber.isPhone { return false }
            return true
        }()
        
        value = {
            guard enabled else { return nil }
            return PayByBankNotificationOptionsRequest(sendEmailNotification: sendEmailNotification,
                                                       email: email,
                                                       sendSMSNotification: sendSmsNotification,
                                                       phoneNumber: phoneNumber)
        }()
    }
}

struct NotificationOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        NotificationOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
