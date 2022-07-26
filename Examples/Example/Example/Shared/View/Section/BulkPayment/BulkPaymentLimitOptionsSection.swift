//
//  BulkPaymentLimitOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct BulkPaymentLimitOptionsSection: View {
   
    @AppStorage(Self.storage(key: .limitOptionsDate)) var date: Date = .default
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: BulkPaymentLimitOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatePicker(selection: $date, displayedComponents: .date) {
                        Text(L10n.inputLimitOptionsDate.localized)
                    }
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: date) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionLimitOptions.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return BulkPaymentLimitOptions(date: date != .default ? date : nil)
        }()
    }
}

struct BulkPaymentLimitOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        BulkPaymentLimitOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
