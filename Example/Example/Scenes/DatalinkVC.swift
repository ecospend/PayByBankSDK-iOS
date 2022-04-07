//
//  DatalinkVC.swift
//  Example
//
//  Created by Berk Akkerman on 7.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import UIKit
import PayByBank
import AVFoundation

class DatalinkVC: UIViewController {
    
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
        
        redirectURLTextField.text = "https://preprodenv.pengpay.io/paycompleted"
        bankIdTextField.text = "11.3"
        merchantIdTextField.text = "Sample Reference"
        merchantUserIdTextField.text = "Sample Description"
        consentEndDateTextField.text = "2023-08-24T14:15:22Z"
        expiryDateTextField.text = "2023-08-24T14:15:22Z"
        permissionsTextField.text = "0,1,2,3"
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
            .split(separator: ",") as? [String]
        
        let datalinkOptions = DatalinkOptions(autoRedirect: autoRedirectSwitch.isOn,
                                              generateQrCode: generateQRSwitch.isOn,
                                              allowMultipleConsent: allowMultipleConsentSwitch.isOn,
                                              generateFinancialReport: generateFinancialReportSwitch.isOn)
        
        let notificationOptions = NotificationOptions(sendEmailNotification: false,
                                                      email: "",
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

// MARK: - Toast
extension DatalinkVC {
    
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: 100, width: 200, height: 50))
        toastLabel.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        toastLabel.textAlignment = .center
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

// MARK: - Loading
extension DatalinkVC {
    
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
extension DatalinkVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Speak
extension DatalinkVC {
    
    func speak(with text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
