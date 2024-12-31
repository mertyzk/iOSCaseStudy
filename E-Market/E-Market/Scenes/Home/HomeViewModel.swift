//
//  HomeVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Properties
    private let networkManager: NetworkManagerProtocol
    private let favoriteManager: FavoriteHandler
    private let cartManager: CartHandler
    
    var products: [Product] = []
    var filteredProducts: [Product] = []
    
    var pageNumber = 1
    private let limit = 4
    
    var numberOfItems: Int {
        return filteredProducts.count
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
        
        networkManager.request(request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products.append(contentsOf: products)
                self.filteredProducts.append(contentsOf: products)
                self.pageNumber += 1
                
                self.onFetchCompletion?(.success(()))
            case .failure(_):
                self.onFetchCompletion?(.failure(.unableToComplete))
            }
        }
    }
    
    
    func product(for index: Int) -> Product? {
        guard !filteredProducts.isEmpty else { return nil }
        return filteredProducts[index]
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
    
    
    func configureFilterOptions() -> Filter {
        let uniqueBrands = Set(products.compactMap { $0.brand })
        let uniqueModels = Set(products.compactMap { $0.model })
        return Filter(brands: Array(uniqueBrands), models: Array(uniqueModels))
    }
    
    
    func makeFilter(selectedFilters: FilterData, completion: @escaping () -> ()) {
        
        if selectedFilters.selectedSortOption == nil &&
             selectedFilters.selectedBrands.isEmpty &&
             selectedFilters.selectedModels.isEmpty {
             self.filteredProducts = products
             completion()
             return
         }
                
        var filteredProducts = filteredProducts
   
        if let sortOption = selectedFilters.selectedSortOption {
            switch sortOption {
            case .fromOldToNew:
                filteredProducts.sort { $0.createdAt ?? "" < $1.createdAt ?? "" }
            case .fromNewToOld:
                filteredProducts.sort { $0.createdAt ?? "" > $1.createdAt ?? "" }
            case .priceHigh:
                filteredProducts.sort { ($0.price ?? "0").toDouble() > ($1.price ?? "0").toDouble() }
            case .priceLow:
                filteredProducts.sort { ($0.price ?? "0").toDouble() < ($1.price ?? "0").toDouble() }
            }
        }
        
        if !selectedFilters.selectedBrands.isEmpty {
            filteredProducts = filteredProducts.filter { product in
                if let brand = product.brand {
                    return selectedFilters.selectedBrands.contains(brand)
                }
                return false
            }
        }
        
        if !selectedFilters.selectedModels.isEmpty {
            filteredProducts = filteredProducts.filter { product in
                if let model = product.model {
                    return selectedFilters.selectedModels.contains(model)
                }
                return false
            }
        }
        
        self.filteredProducts = filteredProducts

        completion()
    }
    
    
    func filterContentForSearchText(_ searchText: String, completion: @escaping () -> ()) {
        if searchText.isEmpty {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { product in
                if let name = product.name, name.lowercased().contains(searchText.lowercased()) {
                    return true
                }
                if let brand = product.brand, brand.lowercased().contains(searchText.lowercased()) {
                    return true
                }
                if let model = product.model, model.lowercased().contains(searchText.lowercased()) {
                    return true
                }
                return false
            }
        }
        completion()
    }
}
