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
    private let productImageView = EMImageView(height: .point150)
    private let favoriteButton   = EMButton(width: .point24, height: .point24, image: Images.emptyStar)
    private let priceLabel       = EMLabel(font: AppTheme.regular(ofSize: .point14), textColor: AppTheme.Colors.navBlue, text: Texts.priceText)
    private let titleLabel       = EMLabel(font: AppTheme.regular(ofSize: .point14), textColor: AppTheme.Colors.systemBlack, text: Texts.titleText)
    private let addToCartButton  = EMButton(font: AppTheme.regular(ofSize: .standartPadding), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.addToCart, cornerRadius: 4)
    
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        favoriteButton.setImage(nil, for: .normal)
        priceLabel.text = nil
        titleLabel.text = nil
    }
    
 
    // MARK: - Helper Functions
    private func configureCell() {
        layer.shadowColor = AppTheme.Colors.systemBlack.cgColor
        layer.shadowOpacity = Float(.pointMin)
        layer.shadowRadius = .cornerRadius
        layer.shadowOffset = CGSize(width: .zero, height: .point2)
        layer.cornerRadius = .point10
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        backgroundColor = .white
    }
    
    
    private func configureUI() {
        [productImageView, priceLabel, titleLabel, addToCartButton].forEach { addSubview($0) }
        productImageView.addSubview(favoriteButton)
        [productImageView, favoriteButton, priceLabel, titleLabel, addToCartButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .point10
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 6),
            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -6),
            
            priceLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: padding + 5),
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding + 5),
            titleLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            
            addToCartButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding + 5),
            addToCartButton.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            addToCartButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            addToCartButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func configureActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        productImageView.isUserInteractionEnabled = true
        productImageView.addGestureRecognizer(tapGesture)
        favoriteButton.addTarget(self, action: #selector(starIconTapped), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(cartBtnTapped), for: .touchUpInside)
    }
    
    
    func configureData(with product: Product, isFavorite: Bool) {
        guard let price = product.price else { return }
        guard let imageURLString = product.image, let imageURL = URL(string: imageURLString) else { return }
        self.product = product
        titleLabel.text = product.name
        priceLabel.text = "\(price.trimDecimalZeros()) \(Texts.tlIconText)"
        favoriteButton.setImage(isFavorite ? Images.filledStar : Images.emptyStar, for: .normal)
        
        NetworkManager.shared.downloadImage(from: imageURL) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async {
                self.productImageView.image = image
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
