//
//  HomeView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - UI Elements
    var searchController = EMSearchBar(frame: .zero)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.layer.borderWidth = 1
        collectionView.layer.cornerRadius = 8
        return collectionView
    }()
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {

    }
}
