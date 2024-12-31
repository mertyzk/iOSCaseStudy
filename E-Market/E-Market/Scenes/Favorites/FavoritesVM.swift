//
//  FavoritesVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class FavoritesVM {
    
    // MARK: - Properties
    private var favoriteHandler: FavoriteHandler
    var favoriteProducts: [Product] = []
    
    var favoritesChanged: ((DBErrors?) -> Void)?
    
    
    // MARK: - Initializer
    init(favoriteHandler: FavoriteHandler) {
        self.favoriteHandler = favoriteHandler
    }
    
    
    // MARK: - Helper Functions
    func getFavoritesFromLocalDB() {
        favoriteHandler.fetchProductsFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                self.favoriteProducts = favorites
                favoritesChanged?(nil)
            case .failure(let failure):
                favoritesChanged?(failure)
            }
        }
    }
    
    
    func deleteProductFromLocalDB(for product: Product) {
        favoriteHandler.deleteFromLocalDB(product: product) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                getFavoritesFromLocalDB()
                NotificationCenter.default.post(name: .favUpdated, object: nil)
            case .failure(let error):
                favoritesChanged?(error)
            }
        }
    }
}
