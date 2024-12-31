//
//  DetailsVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class DetailsViewController: BaseViewController, AlertManager {
    // MARK: - Properties
    private let sView = DetailsView()
    var viewModel: DetailsViewModel
    
    
    // MARK: - Initializer
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        title = viewModel.product.name
        configureBarButton()
        configureUIElements()
        configureActions()
    }
    
    
    // MARK: - Helper Functions
    private func configureBarButton() {
        let leftButton = UIBarButtonItem(image: Images.backIcon, style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        navigationItem.leftBarButtonItem  = leftButton
    }
    
    
    private func configureUIElements() {
        viewModel.setDetailImage { [weak self] img in
            guard let self else { return }
            DispatchQueue.main.async {
                self.sView.detailImageView.image = img
            }
        }
        sView.titleLabel.text = viewModel.product.name
        sView.descriptionLabel.text = viewModel.product.description
        sView.priceValueLabel.text = viewModel.product.price
    }
    
    
    private func configureActions() {
        sView.cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - @Actions
    @objc private func leftBarButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func cartButtonTapped() {
        viewModel.addToCart(product: viewModel.product) { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                self.showAlert(title: AlertConstants.generalErrorTitle, message: error!.rawValue, type: .confirm) {}
                return
            }
            self.showAlert(title: AlertConstants.successCartTitle, message: AlertConstants.successCartDescription, type: .goToCart) {
                let cartViewModel = CartViewModel(cartManager: self.viewModel.cartManager)
                let cartViewController = CartViewController(viewModel: cartViewModel)
                self.navigationController?.pushViewController(cartViewController, animated: false)
            }
        }
    }
}
