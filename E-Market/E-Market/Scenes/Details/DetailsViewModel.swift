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
        var newProduct = product
        newProduct.quantity = 1
        cartManager.addToLocalDB(product: newProduct) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let failure):
                completion(failure)
            }
        }
    }
}
