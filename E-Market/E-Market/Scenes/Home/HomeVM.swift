//
//  HomeVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class HomeVM {
    
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    
    var products: [Product] = []
    
    var numberOfItems: Int {
        return products.count
    }
    
    var onFetchCompletion: ((Result<Void, NetworkErrors>) -> Void)?
    
    
    // MARK: - Initializer
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    
    // MARK: - Helper Functions
    func fetchProducts() {
        let endPoint = Endpoint.getProductsByPagination(page: 1, limit: 4)
        let request = ProductRequest(endpoint: endPoint)
        networkManager.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
                self.onFetchCompletion?(.success(()))
            case .failure(let error):
                self.onFetchCompletion?(.failure(.unableToComplete))
            }
        }
    }
    
}
