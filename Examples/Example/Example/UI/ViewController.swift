//
//  ViewController.swift
//  Example
//
//  Created by Berk Akkerman on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
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
}

// MARK: - Loading
extension ViewController {
    
    func showActivityIndicator() {
        loadingView.frame = view.bounds
        loadingView.addSubview(activityIndicator)
        activityIndicator.center = loadingView.center
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
    }
}

// MARK: - Toast
extension ViewController {
    
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        speak(with: message)
        UIView.animate(withDuration: 3.0, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}

// MARK: - Speak
fileprivate extension ViewController {
    
    func speak(with text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
