//
//  VRPlinkRepository.swift
//  PayByBank
//
//  Created by Yunus TÜR on 15.04.2022.
//  Copyright © 2022 Ecospend. All rights reserved.
//

import Foundation

typealias VRPlinkRepositoryProtocol = VRPlinkRepositoryAsyncProtocol & VRPlinkRepositorySyncProtocol

protocol VRPlinkRepositoryAsyncProtocol {
    func createVRPlink(request: VRPlinkCreateRequest, completion: @escaping (Result<VRPlinkCreateResponse, Error>) -> Void)
    func getVRPlink(request: VRPlinkGetRequest, completion: @escaping (Result<VRPlinkGetResponse, Error>) -> Void)
    func deleteVRPlink(request: VRPlinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void)
    func getVRPlinkRecords(request: VRPlinkGetRecordsRequest, completion: @escaping (Result<VRPlinkGetRecordsResponse, Error>) -> Void)
}

protocol VRPlinkRepositorySyncProtocol {
    func createVRPlink(request: VRPlinkCreateRequest) -> Result<VRPlinkCreateResponse, Error>
    func getVRPlink(request: VRPlinkGetRequest) -> Result<VRPlinkGetResponse, Error>
    func deleteVRPlink(request: VRPlinkDeleteRequest) -> Result<Bool, Error>
    func getVRPlinkRecords(request: VRPlinkGetRecordsRequest) -> Result<VRPlinkGetRecordsResponse, Error>
}

class VRPlinkRepository {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
}

// MARK: - VRPlinkRepositoryAsyncProtocol
extension VRPlinkRepository: VRPlinkRepositoryAsyncProtocol {
    
    func createVRPlink(request: VRPlinkCreateRequest, completion: @escaping (Result<VRPlinkCreateResponse, Error>) -> Void) {
        networking.execute(endpoint: VRPlinkEndpoint.createVRPlink(request), type: VRPlinkCreateResponse.self, completion: completion)
    }
    
    func getVRPlink(request: VRPlinkGetRequest, completion: @escaping (Result<VRPlinkGetResponse, Error>) -> Void) {
        networking.execute(endpoint: VRPlinkEndpoint.getVRPlink(request), type: VRPlinkGetResponse.self, completion: completion)
    }
    
    func deleteVRPlink(request: VRPlinkDeleteRequest, completion: @escaping (Result<Bool, Error>) -> Void) {
        networking.execute(endpoint: VRPlinkEndpoint.deleteVRPlink(request), type: Bool.self, completion: completion)
    }
    
    func getVRPlinkRecords(request: VRPlinkGetRecordsRequest, completion: @escaping (Result<VRPlinkGetRecordsResponse, Error>) -> Void) {
        networking.execute(endpoint: VRPlinkEndpoint.getVRPlinkRecords(request), type: VRPlinkGetRecordsResponse.self, completion: completion)
    }
}

// MARK: - VRPlinkRepositorySyncProtocol
extension VRPlinkRepository: VRPlinkRepositorySyncProtocol {
    
    func createVRPlink(request: VRPlinkCreateRequest) -> Result<VRPlinkCreateResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<VRPlinkCreateResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        createVRPlink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getVRPlink(request: VRPlinkGetRequest) -> Result<VRPlinkGetResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<VRPlinkGetResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getVRPlink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func deleteVRPlink(request: VRPlinkDeleteRequest) -> Result<Bool, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<Bool, Error> = .failure(PayByBankError.unknown(nil))
        
        deleteVRPlink(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
    
    func getVRPlinkRecords(request: VRPlinkGetRecordsRequest) -> Result<VRPlinkGetRecordsResponse, Error> {
        let semaphore = DispatchSemaphore(value: 0)
        var result: Result<VRPlinkGetRecordsResponse, Error> = .failure(PayByBankError.unknown(nil))
        
        getVRPlinkRecords(request: request) { _result in
            result = _result
            semaphore.signal()
        }
        
        semaphore.wait()
        return result
    }
}
