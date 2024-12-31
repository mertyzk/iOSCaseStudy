//
//  CartVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class CartViewController: BaseViewController, AlertManager {
    
    // MARK: - Properties
    var viewModel: CartViewModel
    private let sView = CartView()
    
    init(viewModel: CartViewModel) {
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
        bindingData()
        configureActions()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartItems()
    }
    
    
    // MARK: - Helper Functions
    private func configureTableView() {
        sView.tableView.delegate      = self
        sView.tableView.dataSource    = self
        sView.tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.reuseID)
    }
    
    
    private func getCartItems() {
        viewModel.getCartsFromDB()
    }
    
    
    private func bindingData() {
        viewModel.onChangeCart = { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                showAlert(title: AlertConstants.generalErrorTitle, message: error!.rawValue, type: .confirm) { }
                return
            }
            if viewModel.cartItems.isEmpty {
                self.showEmptyStateView(with: Texts.noDataFound, in: self.view)
            } else {
                self.removeEmptyStateView(from: self.view)
            }
            sView.totalPriceLabel.text = "\(Texts.totalCart) \(viewModel.totalPrice) \(Texts.tlIconText)"
            sView.tableView.reloadAtMainThread()
        }
    }
    
    
    private func configureActions() {
        sView.completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @Actions
    @objc private func completeButtonTapped() {
        showAlert(title: AlertConstants.doYouApproveTheCart, message: "\(AlertConstants.chargedToYourCreditCart)\(viewModel.totalPrice)\(Texts.tlIconText)", type: .approve) { [weak self] in
            guard let self else { return }
            viewModel.deleteAllProducts { error in
                guard error == nil else {
                    self.showAlert(title: AlertConstants.generalErrorTitle, message: error!, type: .confirm) { }
                    return
                }
                self.showAlert(title: AlertConstants.successPurchaseTitle, message: AlertConstants.successPurchaseDescription, type: .confirm) {
                        let homeViewModel = HomeViewModel(favoriteManager: FavoriteStore(), cartManager: CartStore())
                        let homeViewController = HomeViewController(viewModel: homeViewModel)
                        self.navigationController?.pushViewController(homeViewController, animated: false)
                }
            }
        }
    }
}
