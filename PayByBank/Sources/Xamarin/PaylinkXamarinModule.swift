//
//  PayByBankXamarinModule.swift
//  PayByBank
//
//  Created by Yunus TÜR on 17.01.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation
import UIKit

@objc(PaylinkXamarinModule)
public class PaylinkXamarinModule: NSObject {
    
    /// - Parameters:
    ///     - environment: Enum "Sandbox" "Production"
    ///     - clientID: Unique identification string assigned to the client by our system
    ///     - clientSecret: Secret string assigned to the client by our system
    @objc public func configure(environment: String, clientID: String, clientSecret: String) {
        Paylink.shared.configure(environment: PaylinkEnvironment(rawValue: environment ?? "") ?? .sandbox,
                                 clientID: clientID,
                                 clientSecret: clientSecret)
    }
    
    /// - Parameters:
    ///     - paylinkID: Unique id value of paylink.
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    @objc public func open(paylinkID: String, viewController: UIViewController, completion: @escaping (XamarinPayByBankResult?, Error?) -> Void) {
        Paylink.shared.open(paylinkID: paylinkID,
                            viewController: viewController) { result in
            switch result {
            case .success(let PayByBankResult): completion(PayByBankResult.xamarinPaymentResult, nil)
            case .failure(let PayByBankError): completion(nil, PayByBankError)
            }
        }
    }
    
    /// - Parameters:
    ///     - request: Request to create paylink
    ///     - viewController: UIViewController that provides to present bank selection
    ///     - completion: It provides to handle result or error
    @objc public func initiate(request: XamarinPaylinkCreateRequest, viewController: UIViewController, completion: @escaping (XamarinPayByBankResult?, Error?) -> Void) {
        Paylink.shared.initiate(request: request.paylinkCreateRequest,
                                viewController: viewController) { result in
            switch result {
            case .success(let PayByBankResult): completion(PayByBankResult.xamarinPaymentResult, nil)
            case .failure(let PayByBankError): completion(nil, PayByBankError)
            }
        }
    }
}
