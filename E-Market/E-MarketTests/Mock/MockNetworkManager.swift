//
//  MockNetworkManager.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import Foundation
@testable import E_Market

class MockNetworkManager: NetworkManagerProtocol {
    var mockResponses: [String: Any] = [:]

    func request<T: BaseRequest>(_ request: T, completion: @escaping (Result<T.ResponseType, NetworkErrors>) -> Void) {
        let requestKey = String(describing: T.self)

        if let response = mockResponses[requestKey] as? T.ResponseType {
            completion(.success(response))
        } else if let error = mockResponses[requestKey] as? NetworkErrors {
            completion(.failure(error))
        } else {
            completion(.failure(.invalidResponse))
        }
    }


    func setMockResponse<T: BaseRequest>(for requestType: T.Type, response: T.ResponseType) {
        let requestKey = String(describing: T.self)
        mockResponses[requestKey] = response
    }

    
    func setMockError<T: BaseRequest>(for requestType: T.Type, error: NetworkErrors) {
        let requestKey = String(describing: T.self)
        mockResponses[requestKey] = error
    }
}
