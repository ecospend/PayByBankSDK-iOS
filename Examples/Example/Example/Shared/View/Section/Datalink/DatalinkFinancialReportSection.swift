//
//  DatalinkFinancialReportSection.swift
//  Example
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkFinancialReportSection: View {
    
    @State private var isFiltersValid: Bool = false
    @State private var filters: Filters? = nil
    
    @State private var isParametersValid: Bool = false
    @State private var parameters: FinancialReportParameters? = nil
    
    @State private var isOutputSettingsValid: Bool = false
    @State private var outputSettings: OutputSettings? = nil
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var valid: Bool
    @Binding private(set) var value: FinancialReport?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatalinkFiltersSection(valid: $isFiltersValid, value: $filters)
                    DatalinkParametersSection(valid: $isParametersValid, value: $parameters)
                    DatalinkOutputSettingsSection(valid: $isOutputSettingsValid, value: $outputSettings)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: isFiltersValid) { _ in validate() }
        .onChange(of: isParametersValid) { _ in validate() }
        .onChange(of: isOutputSettingsValid) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionFinancialReport.localized, isOn: $isEnabled)
    }
    
    func validate() {
        valid = isFiltersValid && isParametersValid && isOutputSettingsValid
        
        value = {
            guard isEnabled else { return nil }
            return FinancialReport(filters: filters,
                                   parameters: parameters,
                                   outputSettings: outputSettings)
        }()
    }
}

struct DatalinkFinancialReportSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkFinancialReportSection(valid: .constant(true), value: .constant(nil))
    }
}
