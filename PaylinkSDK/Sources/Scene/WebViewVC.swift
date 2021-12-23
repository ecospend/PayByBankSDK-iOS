//
//  WebViewVC.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 9.12.2021.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment  = .fill
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.uiDelegate = self
        view.navigationDelegate = self
        view.allowsBackForwardNavigationGestures = true
        view.configuration.suppressesIncrementalRendering = true
        view.load(URLRequest(url: paylink))
        return view
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped(_:)))
        return view
    }()
    
    var paylink: URL!
    private var observation: NSKeyValueObservation? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Paylink"
        
        setupView()
        setupLayout()
        setupNavigaionController()
        
        observation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.progressView.progress = Float(self.webView.estimatedProgress)
            self.progressView.isHidden = self.progressView.progress == 1
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    deinit {
        webView.stopLoading()
        observation = nil
        print("Deinit WebViewVC")
    }
}

extension WebViewVC {
    
    func setupView() {
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "viewBackground")
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(webView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0),
        ])
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func setupNavigaionController() {
        navigationItem.leftBarButtonItems = [closeButton]
        navigationController?.navigationBar.isTranslucent = false
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(named: "navigationBarBackground")
        } else {
            navigationController?.navigationBar.backgroundColor = .white
        }
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url,
           url.host != paylink.host {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

// MARK: - WKUIDelegate
extension WebViewVC: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard navigationAction.request.url != nil else {
            return nil
        }
        webView.load(navigationAction.request)
        return nil
    }
}
