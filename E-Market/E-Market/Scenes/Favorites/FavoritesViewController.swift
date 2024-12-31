//
//  FavoritesVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit
import CoreData

final class FavoritesViewController: BaseViewController, AlertManager {
    // MARK: - Properties
    private let sView = FavoritesView()
    var viewModel: FavoritesViewModel
    
    
    // MARK: - Initializer
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureCollectionView()
        configureBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    // MARK: - Helper Functions
    private func configureCollectionView() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    private func getFavorites() {
        viewModel.getFavoritesFromLocalDB()
    }
    
    
    private func configureBinding() {
        viewModel.favoritesChanged = { [weak self] error in
            guard let self else { return }
            guard error == nil else {
                self.showAlert(title: AlertConstants.errorTitle, message: error!.rawValue, type: .confirm, completion: {})
                return
            }
            
            if viewModel.favoriteProducts.isEmpty {
                self.showEmptyStateView(with: Texts.noDataFound, in: self.view)
            } else {
                self.removeEmptyStateView(from: self.view)
            }
            
            sView.collectionView.reloadAtMainThread()
        }
    }
}
