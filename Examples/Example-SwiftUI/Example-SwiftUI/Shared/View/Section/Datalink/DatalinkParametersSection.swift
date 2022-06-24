//
//  DatalinkParametersSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkParametersSection: View {
    
    @State private var isAffordabilityValid: Bool = false
    @State private var affordability: AffordabilityParameters? = nil
    
    @State private var isVerificationValid: Bool = false
    @State private var verification: VerificationParameters? = nil
    
    @State private var isFinancialValid: Bool = false
    @State private var financial: FinancialMultiParameters? = nil
    
    @State private var isCategoryValid: Bool = false
    @State private var category: CategoryAggregationParameters? = nil
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: FinancialReportParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    DatalinkAffordabilitySection(isValid: $isAffordabilityValid, value: $affordability)
                    DatalinkVerificationSection(isValid: $isVerificationValid, value: $verification)
                    DatalinkFinancialSection(isValid: $isFinancialValid, value: $financial)
                    DatalinkCategoryAggregationSection(isValid: $isCategoryValid, value: $category)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: isAffordabilityValid) { _ in validate() }
        .onChange(of: isVerificationValid) { _ in validate() }
        .onChange(of: isFinancialValid) { _ in validate() }
        .onChange(of: isCategoryValid) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionParameters.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = isAffordabilityValid && isVerificationValid && isVerificationValid && isCategoryValid
        
        value = {
            guard isEnabled else { return nil }
            let affordabilityList: [AffordabilityParameters]? = {
                guard let affordability = affordability else { return nil }
                return [affordability]
            }()
            return FinancialReportParameters(affordability: affordabilityList,
                                             verification: verification,
                                             financial: financial,
                                             categoryAggregation: category)
        }()
    }
}

struct DatalinkParametersSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkParametersSection(isValid: .constant(true), value: .constant(nil))
    }
}
