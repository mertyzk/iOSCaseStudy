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
    private let favoriteManager: FavoriteHandler
    private let cartManager: CartHandler
    
    var products: [Product] = []
    var filteredProducts: [Product] = []
    
    var pageNumber = 1
    private let limit = 4
    
    var numberOfItems: Int {
        return products.count
    }

    var onFetchCompletion: ((Result<Void, NetworkErrors>) -> Void)?
    

    // MARK: - Initializer
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, favoriteManager: FavoriteHandler, cartManager: CartHandler) {
        self.networkManager = networkManager
        self.favoriteManager = favoriteManager
        self.cartManager = cartManager
    }
    
    
    // MARK: - Helper Functions
    func fetchProducts() {
        let endPoint = Endpoint.getProductsByPagination(page: pageNumber, limit: limit)
        let request = ProductRequest(endpoint: endPoint)
        
        if products.count > 1 {
            print("xxxxxxxxxxx DEBUG: pageNumber \(pageNumber)")
            self.pageNumber += 1
        }
        
        networkManager.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products.append(contentsOf: products)
                self.onFetchCompletion?(.success(()))
            case .failure(_):
                self.onFetchCompletion?(.failure(.unableToComplete))
            }
        }
    }
    
    
    func product(for index: Int) -> Product? {
        guard !products.isEmpty else { return nil }
        return products[index]
    }
    
    
    func isProductFavorite(for product: Product) -> Bool {
        let favProducts = getFavoriteProducts()
        return favProducts.contains(product.id ?? "")
    }
    
    
    func getFavoriteProducts() -> [String] {
        var favoriteProducts: [Product] = []
        
        favoriteManager.fetchProductsFromLocalDB { result in
            switch result {
            case .success(let favorites):
                favoriteProducts = favorites
            case .failure(_):
                break
            }
        }
        return favoriteProducts.compactMap { $0.id }
    }
    
    
    func addToFavorite(product: Product, completion: @escaping (DBErrors?) -> ()) {
        favoriteManager.addToLocalDB(product: product) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    
    func addToCart(product: Product, completion: @escaping (DBErrors?) -> ()) {
        cartManager.addToLocalDB(product: product) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
}
