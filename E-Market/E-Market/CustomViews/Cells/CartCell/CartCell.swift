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
    private let productNameLbl  = EMLabel(font: AppTheme.medium(ofSize: 14), textColor: AppTheme.Colors.systemBlack, text: Texts.appTitle)
    private let productPriceLbl = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let decreaseButton  = EMButton(font: AppTheme.bold(ofSize: 16), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.imageGrayBg, text: Texts.minusBtn, width: 50)
    private let productQuantity = EMLabel(font: AppTheme.medium(ofSize: 16), textColor: AppTheme.Colors.systemWhite, text: "0", bgColor: AppTheme.Colors.navBlue, width: 57, textAlignment: .center)
    private let increaseButton  = EMButton(font: AppTheme.bold(ofSize: 16), textColor: AppTheme.Colors.systemBlack, bgColor: AppTheme.Colors.filterGray, text: Texts.plusBtn, width: 50)
    private lazy var leftStack  = EMStackView(subViews: [productNameLbl, productPriceLbl], axis: .vertical, contentMode: .scaleAspectFit)
    private lazy var rightStck  = EMStackView(subViews: [decreaseButton, productQuantity, increaseButton], axis: .horizontal, contentMode: .scaleAspectFill)
    

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
        [leftStack, rightStck].forEach { addSubview($0) }
        [leftStack, rightStck].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            leftStack.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            leftStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            rightStck.topAnchor.constraint(equalTo: leftStack.topAnchor),
            rightStck.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
            
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
