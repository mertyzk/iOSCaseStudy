//
//  NetworkHelper.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var queryParameters: [String: Any]? { get }
    func request() -> URLRequest
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}


enum Endpoint {
    case getProducts
    case getProductsByPagination(page: Int, limit: Int)
    case getProductDetailById(id: Int)
}


extension Endpoint: EndpointProtocol {

    var baseURL: String {
        return "https://5fc9346b2af77700165ae514.mockapi.io"
    }
    
    
    var path: String {
        switch self {
        case .getProducts:
            return "/v5/launches/upcoming"
        case .getProductsByPagination(let page, let limit):
            return "/products?page=\(page)&limit=\(limit)"
        case .getProductDetailById(let id):
            return "/products/\(id)"
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .get
        case .getProductsByPagination:
            return .get
        case .getProductDetailById:
            return .get
        }
    }
    
    
    var header: [String : String]? {
        let header: [String: String] = ["Content-type": "application/json; charset=UTF-8"]
        return header
    }
    
    
    var queryParameters: [String : Any]? {
        return nil
    }
    
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError(NetworkErrors.invalidURL.rawValue) }
        
        // Add path
        components.path = path
        
        // Create request
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        // Add parameters
        if let queryParameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: queryParameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Add header
        if let header = header {
            for (key, value) in header {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
}
