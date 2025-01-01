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
    var mockError: DBErrors?

    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            completion(.success(mockCartItems))
        }
    }

    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            mockCartItems.append(product)
            completion(.success(()))
        }
    }

    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            mockCartItems.removeAll { $0.id == product.id }
            completion(.success(()))
        }
    }

    func updateProductFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let index = mockCartItems.firstIndex(where: { $0.id == product.id }) {
            mockCartItems[index] = product
            completion(.success(()))
        } else {
            completion(.failure(.updateObjectError))
        }
    }
    
    func removeFromCartFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            if let index = mockCartItems.firstIndex(where: { $0.id == product.id }) {
                mockCartItems[index].quantity = nil
                mockCartItems.remove(at: index)
            }
            completion(.success(()))
        }
    }

    func clearCartFromLocalDB(completion: @escaping (Result<Void, DBErrors>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else {
            mockCartItems.removeAll()
            completion(.success(()))
        }
    }
}
