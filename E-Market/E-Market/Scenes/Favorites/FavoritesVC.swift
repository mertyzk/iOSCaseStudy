//
//  FavoritesVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FavoritesVC: BaseVC {
    // MARK: - Properties
    private let sView = FavoritesView()
    let viewModel = FavoritesVM()
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureCollectionView()
    }
    
    
    // MARK: - Helper Functions
    private func configureCollectionView() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
    }
    
}
