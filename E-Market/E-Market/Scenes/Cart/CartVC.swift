//
//  CartVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class CartVC: BaseVC {
    
    // MARK: - Properties
    let viewModel = CartVM()
    private let sView = CartView()
    
    override func loadView() {
        view = sView
    }
}
