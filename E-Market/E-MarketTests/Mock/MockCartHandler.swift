//
//  MockCartHandler.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import Foundation
@testable import E_Market

class MockCartHandler: CartHandler {
    var mockCartItems: [Product] = []

    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void) {
        completion(.success(mockCartItems))
    }

    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        mockCartItems.append(product)
        completion(.success(()))
    }

    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        mockCartItems.removeAll { $0.id == product.id }
        completion(.success(()))
    }

    func updateProductFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let index = mockCartItems.firstIndex(where: { $0.id == product.id }) {
            mockCartItems[index] = product
        }
        completion(.success(()))
    }

    func removeFromCartFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let index = mockCartItems.firstIndex(where: { $0.id == product.id }) {
            mockCartItems[index].quantity = nil
            mockCartItems.remove(at: index)
        }
        completion(.success(()))
    }

    func clearCartFromLocalDB(completion: @escaping (Result<Void, DBErrors>) -> Void) {
        mockCartItems.removeAll()
        completion(.success(()))
    }
}
