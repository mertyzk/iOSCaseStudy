//
//  HomeCell.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

final class HomeCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID    = "HomeCell"
    private var product: Product?
    
    var onTapCell: ((Product) -> Void)?
    var favoriteButtonTapped: ((Product?) -> Void)?
    var addToCartButtonTapped: ((Product?) -> Void)?
    
    // MARK: - UI Elements
    private let productIV = EMImageView(height: 150)
    private let starBtn   = EMButton(width: 24, height: 24, image: Images.emptyStar)
    private let priceLbl  = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let titleLbl  = EMLabel(font: AppTheme.regular(ofSize: 14), textColor: AppTheme.Colors.systemBlack, text: Texts.titleText)
    private let cartBtn   = EMButton(font: AppTheme.regular(ofSize: 16), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.addToCart, cornerRadius: 4)
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureCell()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    // MARK: - Helper Functions
    private func configureCell() {
        layer.shadowColor = AppTheme.Colors.systemBlack.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.cornerRadius = 10
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        backgroundColor = .white
    }
    
    
    private func configureUI() {
        [productIV, priceLbl, titleLbl, cartBtn].forEach { addSubview($0) }
        productIV.addSubview(starBtn)
        [productIV, starBtn, priceLbl, titleLbl, cartBtn].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            productIV.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            productIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productIV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            starBtn.topAnchor.constraint(equalTo: productIV.topAnchor, constant: 6),
            starBtn.trailingAnchor.constraint(equalTo: productIV.trailingAnchor, constant: -6),
            
            priceLbl.topAnchor.constraint(equalTo: productIV.bottomAnchor, constant: padding + 5),
            priceLbl.leadingAnchor.constraint(equalTo: productIV.leadingAnchor),
            
            titleLbl.topAnchor.constraint(equalTo: priceLbl.bottomAnchor, constant: padding + 5),
            titleLbl.leadingAnchor.constraint(equalTo: priceLbl.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: productIV.trailingAnchor),
            
            cartBtn.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: padding + 5),
            cartBtn.leadingAnchor.constraint(equalTo: productIV.leadingAnchor),
            cartBtn.trailingAnchor.constraint(equalTo: productIV.trailingAnchor),
            cartBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func configureActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        productIV.isUserInteractionEnabled = true
        productIV.addGestureRecognizer(tapGesture)
        starBtn.addTarget(self, action: #selector(starIconTapped), for: .touchUpInside)
        cartBtn.addTarget(self, action: #selector(cartBtnTapped), for: .touchUpInside)
    }
    
    
    func configureData(with product: Product, isFavorite: Bool) {
        guard let price = product.price else { return }
        guard let imageURLString = product.image, let imageURL = URL(string: imageURLString) else { return }
        self.product = product
        titleLbl.text = product.name
        priceLbl.text = "\(price.trimDecimalZeros()) \(Texts.tlIconText)"
        starBtn.setImage(isFavorite ? Images.filledStar : Images.emptyStar, for: .normal)
        
        NetworkManager.shared.downloadImage(from: imageURL) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.productIV.image = image
            }
        }
    }
    
    
    // MARK: - @Actions
    @objc private func starIconTapped() {
        guard let product else { return }
        favoriteButtonTapped?(product)
    }
    
    
    @objc private func cartBtnTapped() {
        guard let product else { return }
        addToCartButtonTapped?(product)
    }
    
    @objc private func didTapCell() {
        guard let product else { return }
        onTapCell?(product)
    }
}
