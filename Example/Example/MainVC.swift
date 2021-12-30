//
//  ViewController.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 9.12.2021.
//

import UIKit
import PaylinkSDK

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
        PaylinkSDK.shared.initiate(request: request, viewController: self) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print("\(error.localizedDescription)")
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
