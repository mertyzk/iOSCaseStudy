//
//  DetailsView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class DetailsView: UIView {
    
    // MARK: - UI Elements
    var detailIV         = EMImageView(height: 225)
    var titleLbl         = EMLabel(font: AppTheme.bold(ofSize: 24), textColor: AppTheme.Colors.systemBlack, text: "")
    var descLbl          = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.systemBlack, text: "")
    private let priceLbl = EMLabel(font: AppTheme.regular(ofSize: 18), textColor: AppTheme.Colors.navBlue, text: Texts.price)
    var priceVal         = EMLabel(font: AppTheme.bold(ofSize: 18), textColor: AppTheme.Colors.systemBlack, text: "")
    var cartBtn          = EMButton(font: AppTheme.bold(ofSize: 20), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.addToCart, width: 182, height: 38, cornerRadius: 4)
    lazy var priceStV    = EMStackView(subViews: [priceLbl, priceVal], axis: .vertical, contentMode: .scaleToFill)
    lazy var lastStV     = EMStackView(subViews: [priceStV, cartBtn], axis: .horizontal, contentMode: .scaleToFill)

    
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
        [detailIV, titleLbl, descLbl, lastStV].forEach { addSubview($0) }
        [detailIV, titleLbl, descLbl, lastStV].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            detailIV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            detailIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            detailIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            titleLbl.topAnchor.constraint(equalTo: detailIV.bottomAnchor, constant: padding),
            titleLbl.leadingAnchor.constraint(equalTo: detailIV.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: detailIV.trailingAnchor),
            
            descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: padding),
            descLbl.leadingAnchor.constraint(equalTo: detailIV.leadingAnchor),
            descLbl.trailingAnchor.constraint(equalTo: detailIV.trailingAnchor),
            
            lastStV.leadingAnchor.constraint(equalTo: detailIV.leadingAnchor),
            lastStV.trailingAnchor.constraint(equalTo: detailIV.trailingAnchor),
            lastStV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
