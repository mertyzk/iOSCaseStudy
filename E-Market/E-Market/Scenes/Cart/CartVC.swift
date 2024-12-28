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
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureTableView()
    }
    
    
    // MARK: - Helper Functions
    private func configureTableView() {
        sView.tableView.delegate      = self
        sView.tableView.dataSource    = self
        sView.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
    }
}
