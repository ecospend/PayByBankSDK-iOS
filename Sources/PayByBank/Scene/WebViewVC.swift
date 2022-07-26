//
//  WebViewVC.swift
//  PayByBank
//
//  Created by Yunus TÜR on 9.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import UIKit
import SafariServices
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
                return UIActivityIndicatorView(style: .large)
            } else {
                return UIActivityIndicatorView(style: .whiteLarge)
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
        view.allowsLinkPreview = false
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
        
        viewModel.openURL { [weak self] url in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.openURL(with: url)
            }
        }
        
        viewModel.openSafari { [weak self] url in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.openSafari(with: url)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        disableDragAndDropInteraction(for: webView)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        viewModel.handler.closeTapped()
    }
    
    deinit {
        webView.stopLoading()
    }
}

// MARK: - Setup
private extension WebViewVC {
    
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
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
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

// MARK: - Logic
private extension WebViewVC {
    
    func disableDragAndDropInteraction(for webView: WKWebView) {
        if #available(iOS 11.0, *) {
            let webScrollView = webView.subviews.compactMap { $0 as? UIScrollView }.first
            let contentView = webScrollView?.subviews.first(where: { $0.interactions.count > 1 })
            guard let dragInteraction = (contentView?.interactions.compactMap { $0 as? UIDragInteraction }.first) else { return }
            contentView?.removeInteraction(dragInteraction)
        }
    }
    
    func disableSelectText(for webView: WKWebView) {
        let cssString = "* { user-select: none; -webkit-user-select: none; -webkit-touch-callout: none; } textarea, input { user-select: text; -webkit-user-select: text }"
        let jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        webView.evaluateJavaScript(jsString, completionHandler: nil)
    }
}

// MARK: - Navigation
private extension WebViewVC {

    func openSafari(with url: URL) {
        let configuration: SFSafariViewController.Configuration = {
            let config = SFSafariViewController.Configuration()
            config.barCollapsingEnabled = false
            return config
        }()
        let safariVC: UIViewController = {
            let vc = SFSafariViewController(url: url, configuration: configuration)
            vc.dismissButtonStyle = .close
            vc.modalPresentationStyle = .popover
            return vc
        }()
        present(safariVC, animated: true)
    }
    
    func openURL(with url: URL) {
        UIApplication.shared.open(url)
    }
}

// MARK: - Loading
private extension WebViewVC {
    
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
        
        if decision == .cancel {
            hideActivityIndicator()
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        disableSelectText(for: webView)
        hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
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
