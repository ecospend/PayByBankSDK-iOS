//
//  ViewController.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 9.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import UIKit
import Paylink

class MainVC: UIViewController {

    @IBOutlet weak var redirectURLTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var referenceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var creditorAccountTypeTextField: UITextField!
    @IBOutlet weak var creditorAccountIdentificationTextField: UITextField!
    @IBOutlet weak var creditorAccountNameTextField: UITextField!
    @IBOutlet weak var creditorAccountCurrencyTextField: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        redirectURLTextField.delegate = self
        amountTextField.delegate = self
        referenceTextField.delegate = self
        descriptionTextField.delegate = self
        creditorAccountTypeTextField.delegate = self
        creditorAccountIdentificationTextField.delegate = self
        creditorAccountNameTextField.delegate = self
        creditorAccountCurrencyTextField.delegate = self
        
        redirectURLTextField.text = "https://preprodenv.pengpay.io/paycompleted"
        amountTextField.text = "11.3"
        referenceTextField.text = "Sample Reference"
        descriptionTextField.text = "Sample Description"
        creditorAccountTypeTextField.text = "SortCode"
        creditorAccountIdentificationTextField.text = "10203012345678"
        creditorAccountNameTextField.text = "John Doe"
        creditorAccountCurrencyTextField.text = "GBP"
    }
    
    // MARK: Action

    @IBAction func payButtomTapped(_ sender: Any) {
        guard let request = request else { return }
        showActivityIndicator()
        Paylink.shared.initiate(request: request, viewController: self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print(response)
                
                switch response.status {
                case .initiated: self.showToast(message: "Paylink was initiated")
                case .completed: self.showToast(message: "Paylink was completed")
                case .deleted: self.showToast(message: "Paylink was deleted")
                }
            case .failure(let error):
                print(error)
                self.showToast(message: "Error: \(error.localizedDescription)")
            }
            self.hideActivityIndicator()
        }
    }
}

// MARK: - Logic
extension MainVC {
    
    var request: PaylinkCreateRequest? {
        guard let redirectURL = URL(string: redirectURLTextField.text ?? ""),
              let amount = Decimal(string: amountTextField.text ?? ""),
              let reference = referenceTextField.text,
              let creditorAccounType = PaylinkAccountType(rawValue: creditorAccountTypeTextField.text ?? ""),
              let creditorAccountIdentification = creditorAccountIdentificationTextField.text,
              let creditorAccountName = creditorAccountNameTextField.text,
              let creditorAccountCurrency = PaylinkCurrency(rawValue: creditorAccountCurrencyTextField.text ?? "") else {
                  return nil
              }
        return PaylinkCreateRequest(
            redirectURL: redirectURL.absoluteString,
            amount: amount,
            reference: reference,
            description: descriptionTextField.text,
            creditorAccount: PaylinkAccount(
                type: creditorAccounType,
                identification: creditorAccountIdentification,
                name: creditorAccountName,
                currency: creditorAccountCurrency
            )
        )
    }
}

// MARK: - Toast
extension MainVC {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 25;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

// MARK: - Loading
extension MainVC {
    
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

// MARK: - UITextFieldDelegate
extension MainVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
