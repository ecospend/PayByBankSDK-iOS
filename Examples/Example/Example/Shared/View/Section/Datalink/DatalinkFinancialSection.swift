//
//  DatalinkFinancialSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkFinancialSection: View {
    
    @AppStorage(Self.storage(key: .financial)) private var financial: Bool = false
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: FinancialMultiParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputFinancial.localized, isOn: $financial)
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: financial) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.inputFinancial.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return FinancialMultiParameters(financial: financial)
        }()
    }
}

struct DatalinkFinancialSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkFinancialSection(valid: .constant(true), value: .constant(nil))
    }
}
