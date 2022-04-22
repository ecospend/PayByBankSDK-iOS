//
//  PaymentVC.swift
//  Example
//
//  Created by Yunus TÜR on 22.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit
import PayByBank

class PaymentVC: ViewController {
    
    @IBOutlet weak var redirectURLTextField: UITextField!
    @IBOutlet weak var bankIDTextField: UITextField!
    @IBOutlet weak var referenceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var creditorAccountTypeTextField: UITextField!
    @IBOutlet weak var creditorAccountIdentificationTextField: UITextField!
    @IBOutlet weak var creditorAccountNameTextField: UITextField!
    @IBOutlet weak var creditorAccountCurrencyTextField: UITextField!
    @IBOutlet weak var mainAreaStackView: UIStackView!
    @IBOutlet weak var creditorAccountAreaStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputAreas = [mainAreaStackView, creditorAccountAreaStackView]
        
        inputAreas.forEach { view in
            view?.layer.cornerRadius = 8
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.systemIndigo.cgColor
            view?.clipsToBounds = true
        }
        
        redirectURLTextField.delegate = self
        bankIDTextField.delegate = self
        referenceTextField.delegate = self
        descriptionTextField.delegate = self
        creditorAccountTypeTextField.delegate = self
        creditorAccountIdentificationTextField.delegate = self
        creditorAccountNameTextField.delegate = self
        creditorAccountCurrencyTextField.delegate = self
        
        redirectURLTextField.text = "https://preprodenv.pengpay.io/paycompleted"
        bankIDTextField.text = "obie-coutts-sandbox"
        referenceTextField.text = "Sample Reference"
        descriptionTextField.text = "Sample Description"
        amountTextField.text = "9.99"
        creditorAccountTypeTextField.text = "SortCode"
        creditorAccountIdentificationTextField.text = "10203012345678"
        creditorAccountNameTextField.text = "John Doe"
        creditorAccountCurrencyTextField.text = "GBP"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: Action
    @IBAction func payButtonTapped(_ sender: Any) {
        guard let request = request else { return }
        showActivityIndicator()
        PayByBank.payment.createPayment(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error)
                    self.showToast(message: "Error: \(error.localizedDescription)")
                }
                self.hideActivityIndicator()
            }
        }
    }
}

// MARK: - Logic
extension PaymentVC {
    
    var request: PaymentCreateRequest? {
        guard let redirectURL = URL(string: redirectURLTextField.text ?? ""),
              let bankID = bankIDTextField.text,
              let reference = referenceTextField.text,
              let amount = Decimal(string: amountTextField.text ?? ""),
              let creditorAccounType = PayByBankAccountType(rawValue: creditorAccountTypeTextField.text ?? ""),
              let creditorAccountIdentification = creditorAccountIdentificationTextField.text,
              let creditorAccountName = creditorAccountNameTextField.text,
              let creditorAccountCurrency = PayByBankCurrency(rawValue: creditorAccountCurrencyTextField.text ?? "")else {
            return nil
        }
        return PaymentCreateRequest(
            redirectURL: redirectURL.absoluteString,
            bankID: bankID,
            amount: amount,
            currency: creditorAccountCurrency,
            description: descriptionTextField.text,
            reference: reference,
            creditorAccount: PayByBankAccountRequest(
                type: creditorAccounType,
                identification: creditorAccountIdentification,
                name: creditorAccountName,
                currency: creditorAccountCurrency)
        )
    }
}

// MARK: - UITextFieldDelegate
extension PaymentVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
