//
//  WebViewVC.swift
//  Paylink SDK POC
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
    
    lazy var loadingView: UIView = {
        let view = UIView()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "viewBackground")
        } else {
            view.backgroundColor = .white
        }
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
        view.uiDelegate = self
        view.navigationDelegate = self
        view.allowsBackForwardNavigationGestures = true
        view.configuration.suppressesIncrementalRendering = true
        view.load(URLRequest(url: viewModel.model.paylinkURL))
        return view
    }()
    
    lazy var closeButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped(_:)))
        return view
    }()
    
    var viewModel: WebViewVM!
    var loadingCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Paylink"
        
        setupView()
        setupLayout()
        setupNavigationController()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appIsActivited),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        viewModel.getPayments()
        
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
        viewModel.deletePaylink()
    }
    
    @IBAction func appIsActivited() {
        viewModel.getPayments()
    }
    
    deinit {
        webView.stopLoading()
        print("Deinit WebViewVC")
    }
}

// MARK: - Setup
extension WebViewVC {
    
    func setupView() {
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "viewBackground")
        } else {
            view.backgroundColor = .white
        }
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(webView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
        
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

// MARK: - Loading
extension WebViewVC {
    
    func showActivityIndicator() {
        loadingCount += 1
        guard loadingCount == 1 else { return }
        
        closeButton.isEnabled = false
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
        
        closeButton.isEnabled = true
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }
}

// MARK: - WKNavigationDelegate
extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            return decisionHandler(.allow)
        }
        
        switch url.host {
        case viewModel.model.paylinkRedirectURL.host:
            if let params = url.queryParameters,
               params["error"] == "user_canceled",
               params["paylink_id"] == viewModel.model.paylinkID {
                viewModel.deletePaylink()
                decisionHandler(.cancel)
            } else {
                decisionHandler(.cancel)
            }
        case viewModel.model.paylinkURL.host:
            decisionHandler(.allow)
        default:
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        }
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
