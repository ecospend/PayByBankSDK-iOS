//
//  SafariView.swift
//  Example-SwiftUI
//
//  Created by Yunus TÜR on 17.06.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let configuration: SFSafariViewController.Configuration = {
            let configuration = SFSafariViewController.Configuration()
            configuration.barCollapsingEnabled = false
            return configuration
        }()
        let vc = SFSafariViewController(url: url, configuration: configuration)
        vc.dismissButtonStyle = .close
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
}
    
}
