//
//  DetailsVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation
import UIKit

final class DetailsViewModel {
    
    // MARK: - Properties
    var product: Product
    let networkManager: NetworkManagerProtocol
    var cartManager: CartHandler
    
    
    // MARK: - Initializer
    init(product: Product, networkManager: NetworkManagerProtocol = NetworkManager.shared, cartManager: CartHandler) {
        self.product = product
        self.networkManager = networkManager
        self.cartManager = cartManager
    }
    
    
    // MARK: - Helper Functions
    func setDetailImage(completion: @escaping (UIImage?) -> ()) {
        guard let image = product.image, let imageURL = URL(string: image) else { return }
        NetworkManager.shared.downloadImage(from: imageURL) { image in
            guard let image else { return }
            completion(image)
        }
    }
    
    
    func addToCart(product: Product, completion: @escaping (DBErrors?) -> ()) {
        cartManager.fetchProductsFromLocalDB { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if let index = products.firstIndex(where: { $0.id == product.id }) {
                    var existingProduct = products[index]
                    existingProduct.quantity = (existingProduct.quantity ?? 0) + 1
                    self.cartManager.updateProductFromLocalDB(product: existingProduct) { result in
                        switch result {
                        case .success(_):
                            completion(nil)
                        case .failure(let error):
                            completion(error)
                        }
                    }
                } else {
                    var newProduct = product
                    newProduct.quantity = 1
                    self.cartManager.addToLocalDB(product: newProduct) { result in
                        switch result {
                        case .success(_):
                            completion(nil)
                        case .failure(let error):
                            completion(error)
                        }
                    }
                }
                NotificationCenter.default.post(name: .changeCartDB, object: nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
