//
//  IamRepository.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 15.12.2021.
//

import Foundation

protocol IamRepositoryProtocol {
    
    /// The respond will return a bearer token that needs to be provided with any subsequent endpoint call within this api.
    /// A keypoint to bear in mind is the 'scope' property. If it is not provided /token endpoint will return a token covering all the scopes available to your client_id.
    func getToken(request: IamTokenRequest, _ completion: @escaping (Result<IamTokenResponse?, Error>) -> Void)
}

class IamRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - IamRepositoryProtocol
extension IamRepository: IamRepositoryProtocol {
    
    func getToken(request: IamTokenRequest, _ completion: @escaping (Result<IamTokenResponse?, Error>) -> Void) {
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
