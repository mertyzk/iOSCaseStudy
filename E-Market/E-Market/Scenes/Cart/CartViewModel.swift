//
//  CartVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class CartViewModel {
    
    // MARK: - Properties
    private var cartManager: CartHandler
    private(set) var cartItems: [Product] = [] {
        didSet {
            notifyCartUpdate()
        }
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { total, product in
            let price = Double(product.price ?? "0") ?? 0
            return total + (price * Double(product.quantity ?? 0))
        }
    }
    
    var onChangeCart: ((DBErrors?) -> Void)?
    
    
    // MARK: - Initializer
    init(cartManager: CartHandler) {
        self.cartManager = cartManager
    }
    
    
    // MARK: - Helper Functions
    func getCartsFromDB() {
        cartManager.fetchProductsFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                cartItems = products
                onChangeCart?(nil)
            case .failure(let error):
                onChangeCart?(error)
            }
        }
    }
    
    private func notifyCartUpdate() {
        NotificationCenter.default.post(name: .changeCartDB, object: nil)
    }
    
    
    func increaseItemQuantity(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            let newQuantity = (cartItems[index].quantity ?? 0) + 1
            cartItems[index].quantity = newQuantity
            
            var updatedProduct = product
            updatedProduct.quantity = newQuantity
            
            cartManager.updateProductFromLocalDB(product: updatedProduct) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(_):
                    self.onChangeCart?(nil)
                case .failure(let error):
                    self.onChangeCart?(error)
                }
            }
        }
    }
    
    
    func decreaseItemQuantity(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.id == product.id }) {
            let currentQuantity = cartItems[index].quantity ?? 0
            if currentQuantity > 1 {
                let newQuantity = currentQuantity - 1
                cartItems[index].quantity = newQuantity
                
                var updatedProduct = product
                updatedProduct.quantity = newQuantity
                
                cartManager.updateProductFromLocalDB(product: updatedProduct) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(_):
                        self.onChangeCart?(nil)
                    case .failure(let error):
                        self.onChangeCart?(error)
                    }
                }
            } else {
                cartManager.deleteFromLocalDB(product: product) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(_):
                        self.onChangeCart?(nil)
                        cartItems.remove(at: index)
                    case .failure(let error):
                        self.onChangeCart?(error)
                    }
                }
            }
        }
    }
    
    
    func deleteAllProducts(completion: @escaping (String?) -> ()) {
        cartManager.clearCartFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.cartItems = []
                completion(nil)
                onChangeCart?(nil)
            case .failure(_):
                completion(Texts.purchaseError)
            }
        }
    }
}
