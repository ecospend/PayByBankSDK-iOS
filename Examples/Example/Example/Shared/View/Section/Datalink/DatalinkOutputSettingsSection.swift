//
//  DatalinkOutputSettingsSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkOutputSettingsSection: View {
    
    @AppStorage(Self.storage(key: .displayPii)) private var displayPii: Bool = false
    
    @State private var enabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: OutputSettings?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Toggle(L10n.inputDisplayPii.localized, isOn: $displayPii)
                }
                .disabled(!enabled)
                .opacity(!enabled ? 0.5 : 1)
            }
        }
        .onChange(of: enabled) { _ in validate() }
        .onChange(of: displayPii) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionOutputSettings.localized, isOn: $enabled)
    }
    
    func validate() {
        valid = true
        
        value = {
            guard enabled else { return nil }
            return OutputSettings(displayPii: displayPii)
        }()
    }
}

struct DatalinkOutputSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkOutputSettingsSection(valid: .constant(true), value: .constant(nil))
    }
}