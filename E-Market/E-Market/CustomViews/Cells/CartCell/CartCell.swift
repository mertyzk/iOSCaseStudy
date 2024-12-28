//
//  CartCell.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

final class CartCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID    = "CartCell"
    
    
    // MARK: - UI Elements
    private let productNameLbl  = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let productPriceLbl = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let decreaseButton  = EMButton(font: AppTheme.bold(ofSize: 16), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.imageGrayBg, text: Texts.minusBtn)
    private let productQuantity = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let increaseButton  = EMButton(font: AppTheme.bold(ofSize: 14), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.filterGray, text: Texts.plusBtn)
    private lazy var leftStack  = EMStackView(subViews: [productNameLbl, productPriceLbl], axis: .vertical, contentMode: .scaleAspectFit)
    private lazy var rightStck  = EMStackView(subViews: [decreaseButton, productQuantity, increaseButton], axis: .horizontal, contentMode: .scaleAspectFit)
    private lazy var mainStack  = EMStackView(subViews: [leftStack, rightStck], axis: .horizontal, contentMode: .scaleToFill)

    

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    
    private var increasePress: (() -> Void)?
    private var decreasePress: (() -> Void)?
    
    
    func configureCell(with product: Product, quantity: Int, increaseItem: @escaping () -> Void, decreaseItem: @escaping () -> Void) {
        productNameLbl.text = product.name
        productPriceLbl.text = product.price
        productQuantity.text = "\(quantity)"
        self.increasePress = increaseItem
        self.decreasePress = decreaseItem
    }

}
