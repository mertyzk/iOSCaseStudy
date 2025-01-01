//
//  MockFavoriteHandler.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import Foundation
@testable import E_Market

class MockFavoriteHandler: FavoriteHandler {
    var mockFavorites: [Product] = []

    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void) {
        completion(.success(mockFavorites))
    }

    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        mockFavorites.append(product)
        completion(.success(()))
    }

    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        mockFavorites.removeAll { $0.id == product.id }
        completion(.success(()))
    }
}
