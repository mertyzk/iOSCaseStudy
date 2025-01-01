//
//  MockProducts.swift
//  E-MarketTests
//
//  Created by Macbook Air on 1.01.2025.
//

import Foundation
@testable import E_Market

let mockProducts: [Product] = [
    Product(
        createdAt: "2023-01-01",
        name: "Product 1",
        image: "https://example.com/product1.png",
        price: "10.99",
        description: "Description for Product 1",
        model: "Model A",
        brand: "Brand X",
        id: "1",
        quantity: 2
    ),
    Product(
        createdAt: "2023-01-02",
        name: "Product 2",
        image: "https://example.com/product2.png",
        price: "15.49",
        description: "Description for Product 2",
        model: "Model B",
        brand: "Brand Y",
        id: "2",
        quantity: 1
    ),
    Product(
        createdAt: "2023-01-03",
        name: "Product 3",
        image: "https://example.com/product3.png",
        price: "20.00",
        description: "Description for Product 3",
        model: "Model C",
        brand: "Brand Z",
        id: "3",
        quantity: 3
    ),
    Product(
        createdAt: "2023-01-04",
        name: "Product 4",
        image: "https://example.com/product4.png",
        price: "25.00",
        description: "Description for Product 4",
        model: "Model A",
        brand: "Brand X",
        id: "4",
        quantity: 5
    ),
    Product(
        createdAt: "2023-01-05",
        name: "Product 5",
        image: "https://example.com/product5.png",
        price: "12.75",
        description: "Description for Product 5",
        model: "Model B",
        brand: "Brand Y",
        id: "5",
        quantity: 0
    ),
    Product(
        createdAt: "2023-01-06",
        name: "Product 6",
        image: "https://example.com/product6.png",
        price: "30.00",
        description: "Description for Product 6",
        model: "Model C",
        brand: "Brand Z",
        id: "6",
        quantity: 1
    )
]
