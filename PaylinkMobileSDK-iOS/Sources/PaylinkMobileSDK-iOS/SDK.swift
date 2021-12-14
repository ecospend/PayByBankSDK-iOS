//
//  SDK.swift
//  PaylinkMobileSDK-iOS
//
//  Created by Berk Akkerman on 9.12.2021.
//

import Foundation
import UIKit

// TODO: Remove
public class SDK {
    
    public static func startWithSafari(root: UIViewController) {
        DispatchQueue.main.async {
            let vc = SafariVC(nibName: "SafariVC", bundle: Bundle(for: Self.self))
            let nc = UINavigationController(rootViewController: vc)
            root.present(nc, animated: true, completion: nil)
        }
    }
    
    public static func startWithWebView(root: UIViewController) {
        DispatchQueue.main.async {
            let vc = WebViewVC(nibName: "WebViewVC", bundle: Bundle(for: Self.self))
            let nc = UINavigationController(rootViewController: vc)
            root.present(nc, animated: true, completion: nil)
        }
    }
}
