//
//  HomeView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - UI Elements
    var searchBar            = EMSearchBar(frame: .zero)
    private let filtersLabel = EMLabel(font: AppTheme.regular(ofSize: 18), textColor: AppTheme.Colors.systemBlack, text: Texts.filters)
    private let filterButton = EMButton(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.filterGray, text: Texts.selectFilt, width: 158)
    private lazy var stackV  = EMStackView(subViews: [filtersLabel, filterButton], axis: .horizontal, contentMode: .scaleAspectFill)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createColumnFlowLayout(in: self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
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
        [searchBar, stackV, collectionView].forEach { addSubview($0) }
        [searchBar, stackV, collectionView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding - 2),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding + 2),
            
            stackV.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            stackV.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            stackV.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: stackV.bottomAnchor, constant: padding + 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
