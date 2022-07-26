//
//  Loading.swift
//  Example
//
//  Created by Yunus TÜR on 16.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

class Loading: ObservableObject {
    @Published fileprivate var isLoading = false
    
    func callAsFunction(_ value: Bool) {
        Task { @MainActor in
            withAnimation(.easeInOut) {
                isLoading = value
            }
        }
    }
}

struct LoadingView<Content: View>: View {
    
    @StateObject var loading = Loading()
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack {
            content
                .environmentObject(loading)
            if loading.isLoading {
                VStack {
                    ProgressView()
                        .scaleEffect(x: 1.5, y: 1.5, anchor: .center)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .background(Color.formBackground.opacity(0.7))
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView { EmptyView() }
    }
}
