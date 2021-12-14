//
//  WebViewVC.swift
//  PaylinkMobileSDK-iOS
//
//  Created by Berk Akkerman on 13.12.2021.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    var webView: WKWebView!
    
    lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        button.setTitle("Close", for: .normal)
        button.titleLabel?.textColor = .orange
        button.backgroundColor = .black
        button.addTarget(nil, action: #selector(self.close), for: .touchUpInside)
        button.layer.cornerRadius = 4
        return button
    }()
    
    var paylink: URL = URL(string: "https://docs.ecospend.com/api/paylink/V2/")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        
        webView.load(URLRequest(url: paylink))
        webView.allowsBackForwardNavigationGestures = true
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

// MARK: - Action
extension WebViewVC {
    
    @objc func close() {
        self.dismiss(animated: true)
    }
}

// MARK: - WKUIDelegate
extension WebViewVC: WKUIDelegate {
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
        view.addSubview(closeButton)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("paylink") { // TODO: change
                decisionHandler(.allow)
                return
            }
        }
        
        decisionHandler(.cancel)
    }
}
