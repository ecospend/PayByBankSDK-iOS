//
//  ViewController.swift
//  Example
//
//  Created by Berk Akkerman on 13.12.2021.
//

import UIKit
import PaylinkMobileSDK_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func openPaylinkWithWebView(_ sender: Any) {
        SDK.startWithWebView(root: self)
    }
    
    @IBAction func openPaylinkWithSafariServices(_ sender: Any) {
        SDK.startWithSafari(root: self)
    }
}
