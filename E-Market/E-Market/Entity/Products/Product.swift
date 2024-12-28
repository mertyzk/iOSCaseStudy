//
//  Product.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

struct Product: Codable {
    let createdAt, name: String?
    let image: String?
    let price, description, model, brand: String?
    let id: String?
    var quantity: Int?
}
