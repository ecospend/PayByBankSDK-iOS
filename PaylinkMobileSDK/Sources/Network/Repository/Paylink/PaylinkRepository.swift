//
//  PaylinkRepository.swift
//  Paylink SDK POC
//
//  Created by Yunus TÜR on 16.12.2021.
//

import Foundation

protocol PaylinkRepositoryProtocol {
    
    func createPaylink(request: PaylinkCreateRequest, completion: @escaping (Result<PaylinkCreateResponse, Error>) -> Void)
    func getPaylink(request: PaylinkGetRequest, completion: @escaping (Result<PaylinkGetResponse, Error>) -> Void)
    func deletePaylink(request: PaylinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
    func getPayments(request: PaylinkPaymentGetRequest, completion: @escaping (Result<[PaylinkPaymentGetResponse], Error>) -> Void)
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
    
    func getPaylink(request: PaylinkGetRequest, completion: @escaping (Result<PaylinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.getPaylink(request), type: PaylinkGetResponse.self) { result in
            switch result {
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func deletePaylink(request: PaylinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.deletePaylink(request), type: Bool.self) { result in
            switch result {
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func getPayments(request: PaylinkPaymentGetRequest, completion: @escaping (Result<[PaylinkPaymentGetResponse], Error>) -> Void) {
        networking.execute(endpoint: PaylinkEndpoint.getPayments(request), type: [PaylinkPaymentGetResponse].self) { result in
            switch result {
            case .success(let response): completion(.success(response))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
