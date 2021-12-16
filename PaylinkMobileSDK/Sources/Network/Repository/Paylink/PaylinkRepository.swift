//
//  PaylinkRepository.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//

import Foundation

protocol PaylinkRepositoryProtocol {
    
    /// The respond will return a bearer token that needs to be provided with any subsequent endpoint call within this api.
    /// A keypoint to bear in mind is the 'scope' property. If it is not provided /token endpoint will return a token covering all the scopes available to your client_id.
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void)
}

class PaylinkRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - IamRepositoryProtocol
extension PaylinkRepository: PaylinkRepositoryProtocol {
    
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.createPaylink(request), type: PaylinkCreateResponse.self) { result in
            switch result {
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
