//
//  DatalinkAffordabilitySection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkAffordabilitySection: View {
    
    @AppStorage(Self.storage(key: .type)) private var type: AffordabilityType = .maxRent
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
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
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: type) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionAffordability.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return AffordabilityParameters(type: [type])
        }()
    }
}

struct DatalinkAffordabilitySection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkAffordabilitySection(valid: .constant(true), value: .constant(nil))
    }
}
