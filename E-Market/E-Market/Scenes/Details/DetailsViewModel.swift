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
    
    
    // MARK: - Initializer
    init(product: Product, networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.product = product
        self.networkManager = networkManager
    }
    
    
    // MARK: - Helper Functions
    func setDetailImage(completion: @escaping (UIImage?) -> ()) {
        guard let image = product.image, let imageURL = URL(string: image) else { return }
        NetworkManager.shared.downloadImage(from: imageURL) { image in
            guard let image else { return }
            completion(image)
        }
    }
}
