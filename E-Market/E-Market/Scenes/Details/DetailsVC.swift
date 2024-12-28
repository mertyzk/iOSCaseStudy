//
//  DetailsVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class DetailsVC: BaseVC {
    // MARK: - Properties
    private let sView = DetailsView()
    var viewModel: DetailsVM
    
    
    // MARK: - Initializer
    init(viewModel: DetailsVM) {
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
                self.sView.detailIV.image = img
            }
        }
        sView.titleLbl.text = viewModel.product.name
        sView.descLbl.text = viewModel.product.description
        sView.priceVal.text = viewModel.product.price
    }
    
    
    // MARK: - @Actions
      @objc private func leftBarButtonItemTapped() {
          navigationController?.popViewController(animated: true)
      }
}
