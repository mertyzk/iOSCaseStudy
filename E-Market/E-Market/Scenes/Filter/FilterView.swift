//
//  FilterView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterView: UIView {
    
    // MARK: - UI Elements
    lazy var sortTableView: UITableView = {
        let tv = tableViewCreator()
        tv.isScrollEnabled = false
        tv.allowsMultipleSelection = false
        return tv
    }()
    
    let brandSearchBar = EMSearchBar(frame: .zero, accessibilityIdentifier: .brandSearchBar)
    
    lazy var brandTableView: UITableView = {
        let tv = tableViewCreator()
        return tv
    }()
    
    let modelSearchBar = EMSearchBar(frame: .zero, accessibilityIdentifier: .modelSearchBar)
    
    lazy var modelTableView: UITableView = {
        let tv = tableViewCreator()
        return tv
    }()
    
    lazy var brandStackView = EMStackView(subViews: [brandSearchBar, brandTableView], axis: .vertical, distribution: .fill)
    lazy var modelStackView = EMStackView(subViews: [modelSearchBar, modelTableView], axis: .vertical, distribution: .fill)
    lazy var stackView = EMStackView(subViews: [sortTableView, brandStackView, modelStackView], axis: .vertical, spacing: 1, distribution: .fillEqually)
    let applyFilterButton = EMButton(font: AppTheme.bold(ofSize: .point22), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.filterText, height: .point38, cornerRadius: .cornerRadius)
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        [stackView, applyFilterButton].forEach { addSubview($0) }
        [stackView, applyFilterButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .standartPadding
        
        NSLayoutConstraint.activate([
            applyFilterButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            applyFilterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            applyFilterButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: applyFilterButton.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: applyFilterButton.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: applyFilterButton.topAnchor, constant: -padding)
        ])
    }
    
    
    private func tableViewCreator() -> UITableView {
        let tv = UITableView()
        tv.backgroundColor = AppTheme.Colors.systemWhite
        tv.contentInset = .zero
        tv.contentInsetAdjustmentBehavior = .never
        tv.alwaysBounceVertical = false
        tv.bounces = false
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }
}
