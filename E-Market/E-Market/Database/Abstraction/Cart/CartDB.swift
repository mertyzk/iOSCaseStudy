//
//  CartDB.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import Foundation

typealias CartHandler = BaseDB & CartDB

protocol CartDB {
    func updateProductFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void)
    func removeFromCartFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void)
    func clearCartFromLocalDB(completion: @escaping (Result<Void, DBErrors>) -> Void)
}
