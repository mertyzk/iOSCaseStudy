//
//  CartView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class CartView: UIView {
    
    // MARK: - UI Elements
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    private let totalTextLabel = EMLabel(font: AppTheme.regular(ofSize: .point18), textColor: AppTheme.Colors.navBlue, text: Texts.total)
    let totalPriceLabel        = EMLabel(font: AppTheme.bold(ofSize: .point18), textColor: AppTheme.Colors.systemBlack, text: Texts.total)
    let completeButton         = EMButton(font: AppTheme.bold(ofSize: .point18), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.complete, width: .point182, cornerRadius: .cornerRadius)
    private lazy var totalStackView  = EMStackView(subViews: [totalTextLabel, totalPriceLabel], axis: .vertical, contentMode: .scaleAspectFill)

    
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
        [totalStackView, completeButton, tableView].forEach { addSubview($0) }
        [totalStackView, completeButton, tableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .standartPadding

        NSLayoutConstraint.activate([
            totalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            completeButton.bottomAnchor.constraint(equalTo: totalStackView.bottomAnchor),
            completeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: totalStackView.topAnchor, constant: -padding)
        ])
    }
}
