//
//  IamRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.12.2021.
//  Copyright © 2021 Ecospend. All rights reserved.
//

import Foundation

typealias IamRepositoryProtocol = IamRepositoryAsyncProtocol & IamRepositorySyncProtocol

protocol IamRepositoryAsyncProtocol {
    func getToken(completion: @escaping (Result<IamTokenResponse, Error>) -> Void)
}

protocol IamRepositorySyncProtocol {
    func getToken() -> Result<IamTokenResponse, Error>
}

class IamRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - IamRepositoryAsyncProtocol
extension IamRepository: IamRepositoryAsyncProtocol {
    
    func getToken(completion: @escaping (Result<IamTokenResponse, Error>) -> Void) {
        switch PayByBankState.Config.authentication {
        case .none:
            return completion(.failure(PayByBankError.notConfigured))
        case .token(let accessToken, let tokenType):
            let response = IamTokenResponse(accessToken: accessToken, tokenType: tokenType)
            PayByBankState.Network.token = response
            return completion(.success(response))
        case .clientCredentials(let clientID, let clientSecret):
            let request = IamTokenRequest(clientID: clientID, clientSecret: clientSecret)
            networking.execute(endpoint: IamEndpoint.token(request), type: IamTokenResponse.self) { result in
                switch result {
                case .success(let response):
                    PayByBankState.Network.token = response
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: - IamRepositorySyncProtocol
extension IamRepository: IamRepositorySyncProtocol {
    
    func getToken() -> Result<IamTokenResponse, Error> {
        // Service Call
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<IamTokenResponse, Error>!
        
        getToken { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
