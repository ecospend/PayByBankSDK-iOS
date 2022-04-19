//
//  FrPaymentVC.swift
//  PayByBank
//
//  Created by Yunus TÜR on 9.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import UIKit
import PayByBank

class FrPaymentVC: ViewController {

    @IBOutlet weak var redirectURLTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var referenceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
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
        amountTextField.delegate = self
        referenceTextField.delegate = self
        descriptionTextField.delegate = self
        creditorAccountTypeTextField.delegate = self
        creditorAccountIdentificationTextField.delegate = self
        creditorAccountNameTextField.delegate = self
        creditorAccountCurrencyTextField.delegate = self
        
        redirectURLTextField.text = "https://preprodenv.pengpay.io/paycompleted"
        amountTextField.text = "9.99"
        referenceTextField.text = "Sample Reference"
        descriptionTextField.text = "Sample Description"
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
        PayByBank.frPayment.initiate(request: request, viewController: self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print(response)
                
                switch response.status {
                case .initiated: self.showToast(message: "FrPayment initiated")
                case .canceled: self.showToast(message: "FrPayment canceled")
                case .redirected: self.showToast(message: "FrPayment redirected")
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
extension FrPaymentVC {
    
    var request: FrPaymentCreateRequest? {
        guard let redirectURL = URL(string: redirectURLTextField.text ?? ""),
              let amount = Decimal(string: amountTextField.text ?? ""),
              let reference = referenceTextField.text,
              let creditorAccounType = PayByBankAccountType(rawValue: creditorAccountTypeTextField.text ?? ""),
              let creditorAccountIdentification = creditorAccountIdentificationTextField.text,
              let creditorAccountName = creditorAccountNameTextField.text,
              let creditorAccountCurrency = PayByBankCurrency(rawValue: creditorAccountCurrencyTextField.text ?? "") else {
                  return nil
              }
        return FrPaymentCreateRequest(
            redirectURL: redirectURL.absoluteString,
            amount: amount,
            reference: reference,
            description: descriptionTextField.text,
            creditorAccount: PayByBankAccountRequest(
                type: creditorAccounType,
                identification: creditorAccountIdentification,
                name: creditorAccountName,
                currency: creditorAccountCurrency
            ),
            firstPaymentDate: "2023-08-24T14:15:22Z",
            numberOfPayments: 1,
            period: .weekly
        )
    }
}

// MARK: - UITextFieldDelegate
extension FrPaymentVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
