//
//  CartVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class CartVC: BaseVC {
    
    // MARK: - Properties
    var viewModel: CartVM
    private let sView = CartView()
    
    init(viewModel: CartVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureTableView()
        viewModel.getTest()
    }
    
    
    // MARK: - Helper Functions
    private func configureTableView() {
        sView.tableView.delegate      = self
        sView.tableView.dataSource    = self
        sView.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
    }
}
