//
//  NetworkManager.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() { }
    
    func request<T: BaseRequest>(_ request: T, completion: @escaping (Result<T.ResponseType, NetworkErrors>) -> Void) {
        NotificationCenter.default.post(name: .showLoading, object: nil)
        
        URLSession.shared.dataTask(with: request.endpoint.request()) { data, response, error in
            
            defer {
                NotificationCenter.default.post(name: .hideLoading, object: nil)
            }
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.ResponseType.self, from: data)
                
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("xxxxxxxxxxx DEBUG: Image loading error => \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            completion(image)
        }.resume()
    }
}
