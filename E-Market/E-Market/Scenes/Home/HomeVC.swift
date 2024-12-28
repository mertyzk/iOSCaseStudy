//
//  HomeVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeVC: BaseVC {
    
    // MARK: - Properties
    private let sView = HomeView()
    private var viewModel: HomeVM
    
    
    // MARK: - DeInitializer
    deinit {
        
    }
    
    
    // MARK: - Initializer
    init(viewModel: HomeVM) {
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
    }
    
    
    // MARK: - Helper Functions
    private func configureCollectionView() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
    }
    
    
    // MARK: - @Actions
}
