//
//  NetworkManager.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func request<T: Decodable>(_ endpoint: Endpoint, responseType: T.Type) async throws -> T {
        NotificationCenter.default.post(name: .showLoading, object: nil)
        let request = endpoint.request()
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            NotificationCenter.default.post(name: .hideLoading, object: nil)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkErrors.invalidResponse
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                throw NetworkErrors.invalidData
            }
            
        } catch {
            throw NetworkErrors.unableToComplete
        }
    }
    
}
