//
//  DetailsView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class DetailsView: UIView {
    
    // MARK: - UI Elements
    var detailImageView     = EMImageView(height: .point225)
    var titleLabel          = EMLabel(font: AppTheme.bold(ofSize: .point24), textColor: AppTheme.Colors.systemBlack, text: "")
    var descriptionLabel    = EMLabel(font: AppTheme.regular(ofSize: .point14), textColor: AppTheme.Colors.systemBlack, text: "")
    private let priceLabel  = EMLabel(font: AppTheme.regular(ofSize: .point18), textColor: AppTheme.Colors.navBlue, text: Texts.price)
    var priceValueLabel     = EMLabel(font: AppTheme.bold(ofSize: .point18), textColor: AppTheme.Colors.systemBlack, text: "")
    var cartButton          = EMButton(font: AppTheme.bold(ofSize: .point20), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.addToCart, width: .point182, height: .point38, cornerRadius: .cornerRadius)
    lazy var priceStackView = EMStackView(subViews: [priceLabel, priceValueLabel], axis: .vertical, contentMode: .scaleToFill)
    lazy var lastStackView  = EMStackView(subViews: [priceStackView, cartButton], axis: .horizontal, contentMode: .scaleToFill)

    
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
        [detailImageView, titleLabel, descriptionLabel, lastStackView].forEach { addSubview($0) }
        [detailImageView, titleLabel, descriptionLabel, lastStackView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .standartPadding

        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            detailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            detailImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            titleLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: detailImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: detailImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor),
            
            lastStackView.leadingAnchor.constraint(equalTo: detailImageView.leadingAnchor),
            lastStackView.trailingAnchor.constraint(equalTo: detailImageView.trailingAnchor),
            lastStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
