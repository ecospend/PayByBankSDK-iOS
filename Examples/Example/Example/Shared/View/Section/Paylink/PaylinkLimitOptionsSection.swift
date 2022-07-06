//
//  PaylinkLimitOptionsSection.swift
//  Example
//
//  Created by Yunus TÜR on 16.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct PaylinkLimitOptionsSection: View {
    
    @AppStorage(Self.storage(key: .limitOptionsCount)) var count: Int = 0
    @AppStorage(Self.storage(key: .limitOptionsAmount)) var amount: Decimal = 0
    @AppStorage(Self.storage(key: .limitOptionsDate)) var date: Date = .default
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: PaylinkLimitOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    TextField("", value: $count, format: .number)
                        .keyboardType(.numberPad)
                        .titled(L10n.inputLimitOptionsCount.localized)
                    TextField("", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .titled(L10n.inputLimitOptionsAmount.localized)
                    DatePicker(selection: $date, displayedComponents: .date) {
                        Text(L10n.inputLimitOptionsDate.localized)
                    }
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: count) { _ in validate() }
        .onChange(of: amount) { _ in validate() }
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
            return PaylinkLimitOptions(count: count > 0 ? count : nil,
                                       amount: amount > 0 ? amount : nil,
                                       date: date != .default ? date.rawValue : nil)
        }()
    }
}

struct PaylinkLimitOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        PaylinkLimitOptionsSection(valid: .constant(true), value: .constant(nil))
    }
}
