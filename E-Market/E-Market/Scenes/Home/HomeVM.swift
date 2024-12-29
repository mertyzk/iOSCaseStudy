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
    var selectedFilters: [String: [String]] = [:]
    var selectedSortOption: SortingOptions?
    var numberOfItems: Int {
        return products.count
    }
    
    enum FilterType: String {
        case Brand
        case Model
    }
    
    var sortSelections: [String] {
        return SortingOptions.allCases.map { $0.rawValue }
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
        let favProducts = getFavProducts()
        return favProducts.contains(product.id ?? "")
    }
    
    
    func getFavProducts() -> [String] {
        //guard let favoriteProducts = try? favoriteDB.fetchProductList() else { return [] }
       // return favoriteProducts.compactMap { $0.id }
        return [""]
    }
    
    func configureFilterOptions() -> [[String: [String]]] {
        let uniqueBrands = Set(products.compactMap { $0.brand }).sorted()
        let uniqueModels = Set(products.compactMap { $0.model }).sorted()
        return [[FilterType.Brand.rawValue: uniqueBrands], [FilterType.Model.rawValue: uniqueModels]]
    }
}
