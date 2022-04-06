//
//  WebViewVC.swift
//  PayByBank SDK POC
//
//  Created by Yunus TÜR on 9.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
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
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        view.backgroundColor = .clear
        view.setImage(PayByBankImages.close.image, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = PayByBankColors.viewBackground.color
        view.alpha = 0.7
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView = {
            if #available(iOS 13.0, *) {
                return UIActivityIndicatorView(style: .medium)
            } else {
                return UIActivityIndicatorView(style: .white)
            }
        }()
        return view
    }()
    
    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.scrollView.alwaysBounceVertical = false
        view.scrollView.bounces = false
        view.uiDelegate = self
        view.navigationDelegate = self
        view.allowsBackForwardNavigationGestures = true
        view.configuration.suppressesIncrementalRendering = true
        view.load(URLRequest(url: viewModel.handler.webViewURL))
        return view
    }()
    
    var viewModel: WebViewVM!
    var loadingCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        
        viewModel.dismiss { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.navigationController?.dismiss(animated: true)
            }
        }
        
        viewModel.loading { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch isLoading {
                case true: self.showActivityIndicator()
                case false: self.hideActivityIndicator()
                }
            }
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        viewModel.handler.closeTapped()
    }
    
    deinit {
        webView.stopLoading()
    }
}

// MARK: - Setup
extension WebViewVC {
    
    func setupView() {
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        
        navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = PayByBankColors.viewBackground.color
        view.addSubview(stackView)
        stackView.addArrangedSubview(topView)
        topView.addSubview(closeButton)
        stackView.addArrangedSubview(webView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            closeButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Loading
extension WebViewVC {
    
    func showActivityIndicator() {
        loadingCount += 1
        guard loadingCount == 1 else { return }
        
        loadingView.frame = view.bounds
        loadingView.addSubview(activityIndicator)
        activityIndicator.center = loadingView.center
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        loadingCount -= 1
        if loadingCount < 0 { loadingCount = 0 }
        guard loadingCount == 0 else { return }
        
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }
}

// MARK: - WKNavigationDelegate
extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let decision = viewModel.handler.webViewDecision(url: navigationAction.request.url)
        decisionHandler(decision)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityIndicator()
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
