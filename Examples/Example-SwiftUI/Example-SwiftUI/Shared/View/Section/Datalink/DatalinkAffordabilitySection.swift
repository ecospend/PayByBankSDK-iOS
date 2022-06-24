//
//  DatalinkAffordabilitySection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkAffordabilitySection: View {
    
    @AppStorage(Self.storage(key: .type)) private var type: AffordabilityType = .maxRent
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: AffordabilityParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Menu(type.rawValue) {
                        Button(AffordabilityType.maxRent.rawValue) { type = .maxRent }
                        Button(AffordabilityType.maxInstallments.rawValue) { type = .maxInstallments }
                        Button(AffordabilityType.gamblingLimit.rawValue) { type = .gamblingLimit }
                    }
                    .titled(L10n.inputType.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: type) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionAffordability.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return AffordabilityParameters(type: [type])
        }()
    }
}

struct DatalinkAffordabilitySection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkAffordabilitySection(isValid: .constant(true), value: .constant(nil))
    }
}
