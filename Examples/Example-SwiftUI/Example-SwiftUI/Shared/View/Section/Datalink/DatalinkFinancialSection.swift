//
//  DatalinkFinancialSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkFinancialSection: View {
    
    @AppStorage(Self.storage(key: .financial)) private var financial: Bool = false
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: FinancialMultiParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputFinancial.localized, isOn: $financial)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: financial) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.inputFinancial.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return FinancialMultiParameters(financial: financial)
        }()
    }
}

struct DatalinkFinancialSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkFinancialSection(isValid: .constant(true), value: .constant(nil))
    }
}
