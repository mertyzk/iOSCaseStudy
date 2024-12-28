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
    
    private let totalTextLabel = EMLabel(font: AppTheme.regular(ofSize: 18), textColor: AppTheme.Colors.navBlue, text: Texts.total)
    let totalPriceLabel        = EMLabel(font: AppTheme.bold(ofSize: 18), textColor: AppTheme.Colors.systemBlack, text: "TL")
    let completeButton         = EMButton(font: AppTheme.bold(ofSize: 18), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.complete, width: 182, cornerRadius: 4)
    private lazy var totalStV  = EMStackView(subViews: [totalTextLabel, totalPriceLabel], axis: .vertical, contentMode: .scaleAspectFill)

    
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
        [totalStV, completeButton, tableView].forEach { addSubview($0) }
        [totalStV, completeButton, tableView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            totalStV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            totalStV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            completeButton.bottomAnchor.constraint(equalTo: totalStV.bottomAnchor),
            completeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            tableView.bottomAnchor.constraint(equalTo: totalStV.topAnchor, constant: -padding)
        ])
    }
}
