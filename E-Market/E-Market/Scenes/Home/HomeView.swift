//
//  HomeView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - UI Elements
    var searchBar               = EMSearchBar(frame: .zero)
    private let filtersLabel    = EMLabel(font: AppTheme.regular(ofSize: .point18), textColor: AppTheme.Colors.systemBlack, text: Texts.filters)
    let filterButton            = EMButton(font: AppTheme.regular(ofSize: .point14), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.filterGray, text: Texts.selectFilt, width: .point158)
    private lazy var stackView  = EMStackView(subViews: [filtersLabel, filterButton], axis: .horizontal, contentMode: .scaleAspectFill)
    
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
        [searchBar, stackView, collectionView].forEach { addSubview($0) }
        [searchBar, stackView, collectionView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .standartPadding

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: .point14),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding - 2),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding + 2),
            
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding + 8),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
