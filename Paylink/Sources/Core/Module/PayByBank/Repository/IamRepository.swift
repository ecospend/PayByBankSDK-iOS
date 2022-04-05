//
//  IamRepository.swift
//  Paylink SDK POC
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
        guard let clientID = PaylinkState.Config.clientID,
              let clietSecret = PaylinkState.Config.clientSecret else {
            return completion(.failure(PaylinkError.notConfigured))
        }
        
        let request = IamTokenRequest(clientID: clientID, clientSecret: clietSecret)
        networking.execute(endpoint: IamEndpoint.token(request), type: IamTokenResponse.self) { result in
            switch result {
            case .success(let response):
                PaylinkState.Network.token = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
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
        
        getToken() { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
