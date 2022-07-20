//
//  Toast.swift
//  Example
//
//  Created by Yunus TÜR on 20.05.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI

class Toast: ObservableObject {
    @Published fileprivate var title: String?
    
    func callAsFunction(_ value: String?) {
        Task { @MainActor in
            withAnimation {
                title = value
            }
        }
    }
}

struct ToastView<Content: View>: View {
    
    @StateObject var toast: Toast = Toast()
    @ViewBuilder let content: Content
    
    var body: some View {
        ZStack {
            content
                .environmentObject(toast)
            if let title = toast.title {
                VStack {
                    Group {
                        Text(title)
                            .fontWeight(.bold)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                    }
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .onTapGesture {
                        toast(nil)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            toast(nil)
                        }
                    }
                    Spacer()
                }
                .transition(.move(edge: .top))
            }
        }
    }
}


struct ToastView_Previews: PreviewProvider {
    
    static var previews: some View {
        ToastView { EmptyView() }
    }
}
