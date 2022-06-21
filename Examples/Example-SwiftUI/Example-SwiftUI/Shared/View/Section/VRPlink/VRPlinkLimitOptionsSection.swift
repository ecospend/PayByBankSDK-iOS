//
//  VRPlinkLimitOptionsSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 21.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct VRPlinkLimitOptionsSection: View {
    
    @AppStorage(Self.storage(key: .limitOptionsDate)) var date: Date = .default
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: VRPlinkLimitOptions?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatePicker(selection: $date, displayedComponents: .date) {
                        Text(L10n.inputLimitOptionsDate.localized)
                    }
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: date) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionVRPlinkLimitOptions.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return VRPlinkLimitOptions(date: date != .default ? date.rawValue : nil)
        }()
    }
}

struct VRPlinkLimitOptionsSection_Previews: PreviewProvider {
    static var previews: some View {
        VRPlinkLimitOptionsSection(isValid: .constant(true), value: .constant(nil))
    }
}
