//
//  FavoritesVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit
import CoreData

final class FavoritesVC: BaseVC {
    // MARK: - Properties
    private let sView = FavoritesView()
    let asdsa = FavoriteStore(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    var viewModel: FavoritesVM?
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureCollectionView()
        viewModel = FavoritesVM(favoriteHandler: asdsa)
    }
    
    
    // MARK: - Helper Functions
    private func configureCollectionView() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
    }
    
}
