//
//  BaseDBInterface.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import Foundation

protocol BaseDB {
    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void)
    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void)
    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void)
}
