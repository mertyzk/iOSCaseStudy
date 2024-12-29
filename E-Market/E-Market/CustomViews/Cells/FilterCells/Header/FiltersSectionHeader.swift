//
//  FiltersSectionHeader.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

final class FiltersSectionHeader: UITableViewHeaderFooterView {
    
    // MARK: - Properties
    static let reuseID     = "FilterSectionHeader"
    
    
    // MARK: - UI Elements
    private let titleLabel = EMLabel(font: AppTheme.regular(ofSize: 12), textColor: AppTheme.Colors.systemBlack.withAlphaComponent(0.5), text: Texts.appTitle)
    let searchBar          = EMSearchBar()
    private let containerV = UIView()

    
    // MARK: - Initializer
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(containerV)
        containerV.addSubview(titleLabel)
        containerV.addSubview(searchBar)
        
        let padding: CGFloat = 16
        
        [containerV, titleLabel, searchBar].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            containerV.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerV.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerV.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerV.trailingAnchor),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 2),
            searchBar.leadingAnchor.constraint(equalTo: containerV.leadingAnchor, constant: padding),
            searchBar.trailingAnchor.constraint(equalTo: containerV.trailingAnchor, constant: -padding),
            searchBar.bottomAnchor.constraint(equalTo: containerV.bottomAnchor, constant: -padding)
        ])
    }

    func configure(title: String, searchBarDelegate: UISearchBarDelegate?, isSearchBarVisible: Bool) {
        let padding: CGFloat = 16
        titleLabel.text = title
        
        if isSearchBarVisible {
            containerV.addSubview(searchBar)
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 2),
                searchBar.leadingAnchor.constraint(equalTo: containerV.leadingAnchor, constant: padding),
                searchBar.trailingAnchor.constraint(equalTo: containerV.trailingAnchor, constant: -padding),
                searchBar.bottomAnchor.constraint(equalTo: containerV.bottomAnchor, constant: -padding / 2)
            ])
        } else {
            searchBar.removeFromSuperview()
            NSLayoutConstraint.activate([
                titleLabel.bottomAnchor.constraint(equalTo: containerV.bottomAnchor, constant: -padding)
            ])
        }
        
        guard let searchBarDelegate else { return }
        searchBar.setDelegate(searchBarDelegate)
    }
    
    func contains(searchBar: UISearchBar) -> Bool {
        self.searchBar == searchBar
    }
}
