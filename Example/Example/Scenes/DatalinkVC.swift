//
//  DatalinkVC.swift
//  Example
//
//  Created by Berk Akkerman on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit
import PayByBank

class DatalinkVC: ViewController {
    
    @IBOutlet weak var datalinkStackView: UIStackView!
    @IBOutlet weak var datalinkOptionsStackView: UIStackView!
    
    @IBOutlet weak var redirectURLTextField: UITextField!
    @IBOutlet weak var bankIdTextField: TextField!
    @IBOutlet weak var merchantIdTextField: TextField!
    @IBOutlet weak var merchantUserIdTextField: TextField!
    @IBOutlet weak var consentEndDateTextField: TextField!
    @IBOutlet weak var expiryDateTextField: TextField!
    @IBOutlet weak var permissionsTextField: TextField!
    @IBOutlet weak var autoRedirectSwitch: UISwitch!
    @IBOutlet weak var generateQRSwitch: UISwitch!
    @IBOutlet weak var allowMultipleConsentSwitch: UISwitch!
    @IBOutlet weak var generateFinancialReportSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputAreas = [datalinkStackView, datalinkOptionsStackView]
        
        inputAreas.forEach { view in
            view?.layer.cornerRadius = 8
            view?.layer.borderWidth = 2
            view?.layer.borderColor = UIColor.systemIndigo.cgColor
            view?.clipsToBounds = true
        }
        
        redirectURLTextField.delegate = self
        bankIdTextField.delegate = self
        merchantIdTextField.delegate = self
        merchantUserIdTextField.delegate = self
        consentEndDateTextField.delegate = self
        expiryDateTextField.delegate = self
        permissionsTextField.delegate = self
        
        autoRedirectSwitch.isOn = false
        redirectURLTextField.text = "https://preprodenv.pengpay.io/accountcompleted"
        bankIdTextField.text = UUID().uuidString // TODO: fix
        merchantIdTextField.text = "Merchant Id"
        merchantUserIdTextField.text = "Merchant User Id"
        consentEndDateTextField.text = "2023-08-24T14:15:22Z"
        expiryDateTextField.text = "2023-08-24T14:15:22Z"
        permissionsTextField.text = [ConsentPermission.balance, ConsentPermission.account, ConsentPermission.trasactions]
            .map { $0.rawValue }
            .joined(separator: ",")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let request = request else { return }
        showActivityIndicator()
        PayByBank.datalink.initiate(request: request, viewController: self) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                print(response)
                
                switch response.status {
                case .initiated: self.showToast(message: "Datalink initiated")
                case .canceled: self.showToast(message: "Datalink canceled")
                case .redirected: self.showToast(message: "Datalink redirected")
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
extension DatalinkVC {
    
    var request: DatalinkCreateRequest? {
        
        guard let redirectURL = redirectURLTextField.text,
              let bankId = bankIdTextField.text,
              let merchantId = merchantIdTextField.text,
              let merchantUserId = merchantUserIdTextField.text,
              let consentEndDate = consentEndDateTextField.text,
              let expriyDate = expiryDateTextField.text
        else {
            return nil
        }
        
        let permissions = permissionsTextField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .map { ConsentPermission(rawValue: String($0)) }
            .filter { $0 != nil }
            .map { $0! }
        
        let datalinkOptions = DatalinkOptions(autoRedirect: autoRedirectSwitch.isOn,
                                              generateQrCode: generateQRSwitch.isOn,
                                              allowMultipleConsent: allowMultipleConsentSwitch.isOn,
                                              generateFinancialReport: generateFinancialReportSwitch.isOn)
        
        let notificationOptions = NotificationOptions(sendEmailNotification: false,
                                                      email: "example@email.com",
                                                      sendSMSNotification: false,
                                                      phoneNumber: "")
        
        let financialReport = FinancialReport(filters: Filters(startDate: "2020-08-24T14:15:22Z", currency: .gbp),
                                              parameters: FinancialReportParameters(affordability: nil,
                                                                                    verification: VerificationParameters(name: nil,
                                                                                                                         phoneNumbers: nil,
                                                                                                                         address: nil,
                                                                                                                         email: nil),
                                                                                    financial: FinancialMultiParameters(financial: true),
                                                                                    categoryAggregation: CategoryAggregationParameters(distributionPeriod: .year)),
                                              outputSettings: OutputSettings(displayPii: true))
        
         return DatalinkCreateRequest(redirectURL: redirectURL,
                                     bankId: bankId,
                                     merchantId: merchantId,
                                     merchantUserId: merchantUserId,
                                     consentEndDate: consentEndDate,
                                     expiryDate: expriyDate,
                                     permissions: permissions,
                                     datalinkOptions: datalinkOptions,
                                     notificationOptions: notificationOptions,
                                     financialReport: financialReport)
    }
}

// MARK: - UITextFieldDelegate
extension DatalinkVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
