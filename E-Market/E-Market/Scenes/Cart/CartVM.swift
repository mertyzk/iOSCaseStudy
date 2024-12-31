//
//  CartVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class CartVM {
    
    private var cartManager: CartHandler
    
    init(cartManager: CartHandler) {
        self.cartManager = cartManager
    }
    
    func getTest() {
        cartManager.fetchProductsFromLocalDB { result in
            switch result {
            case .success(let products):
                print("xxxxxxxxxxx DEBUG: \(products)")
            case .failure(let error):
                print("xxxxxxxxxxx DEBUG: \(error)")
            }
        }
    }
    
}
