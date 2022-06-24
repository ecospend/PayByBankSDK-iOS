//
//  DatalinkCategoryAggregationSection.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 23.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import PayByBank

struct DatalinkCategoryAggregationSection: View {
    
    @AppStorage(Self.storage(key: .distributionPeriod)) private var distributionPeriod: DistrubutionPeriod = .month
    
    @State private var isEnabled: Bool = false
    @Binding private(set) var isValid: Bool
    @Binding private(set) var value: CategoryAggregationParameters?
    
    var body: some View {
        List {
            Section(header: header) {
                Group {
                    Menu(distributionPeriod.rawValue) {
                        Button(DistrubutionPeriod.month.rawValue) { distributionPeriod = .month }
                        Button(DistrubutionPeriod.quarter.rawValue) { distributionPeriod = .quarter }
                        Button(DistrubutionPeriod.year.rawValue) { distributionPeriod = .year }
                    }
                    .titled(L10n.inputDistributionPeriod.localized)
                }
                .disabled(!isEnabled)
                .opacity(!isEnabled ? 0.5 : 1)
            }
        }
        .onChange(of: isEnabled) { _ in validate() }
        .onChange(of: distributionPeriod) { _ in validate() }
        .onAppear { validate() }
    }
    
    @ViewBuilder
    var header: some View {
        Toggle(L10n.sectionCategoryAggregation.localized, isOn: $isEnabled)
    }
    
    func validate() {
        isValid = true
        
        value = {
            guard isEnabled else { return nil }
            return CategoryAggregationParameters(distributionPeriod: distributionPeriod)
        }()
    }
}

struct DatalinkCategoryAggregationSection_Previews: PreviewProvider {
    static var previews: some View {
        DatalinkCategoryAggregationSection(isValid: .constant(true), value: .constant(nil))
    }
}
