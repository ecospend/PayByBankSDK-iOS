//
//  SafariVC.swift
//  PaylinkMobileSDK-iOS
//
//  Created by Berk Akkerman on 9.12.2021.
//

import UIKit
import SafariServices

class SafariVC: UIViewController {
    
    var paylink: URL = URL(string: "https://docs.ecospend.com/api/paylink/V2/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        
        addSFSafariViewController(paylink)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Logic
extension SafariVC {
    
    func addSFSafariViewController(_ url: URL) {
        let vc = generateSFSafariViewController(url)
        // Add Child View Controller
        addChild(vc)
        // Add Child View as Subview
        view.addSubview(vc.view)
        // Configure Child View
        vc.view.frame = view.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Notify Child View Controller
        vc.didMove(toParent: self.parent)
    }
    
    func generateSFSafariViewController(_ url: URL) -> SFSafariViewController {
        let vc: SFSafariViewController = {
            if #available(iOS 11, *) {
                
                let configuration: SFSafariViewController.Configuration = {
                    let config = SFSafariViewController.Configuration()
                    config.entersReaderIfAvailable = false
                    config.barCollapsingEnabled = false
                    return config
                }()
                
                let vc = SFSafariViewController(url: url, configuration: configuration)
                vc.dismissButtonStyle = .close
                return vc
            } else {
                return SFSafariViewController(url: url, entersReaderIfAvailable: false)
            }
        }()
        
        vc.delegate = self
        return vc
    }
}

// MARK: - SFSafariViewControllerDelegate
extension SafariVC: SFSafariViewControllerDelegate {
    // TODO: Not yet implemented...
}
