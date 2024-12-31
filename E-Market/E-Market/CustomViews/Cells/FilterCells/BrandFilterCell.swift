//
//  FilterSelectCell.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

final class BrandFilterCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID    = "BrandFilterCell"
    
    
    // MARK: - UI Elements
    let checkBoxImageView  = EMImageView(image: Images.emptyCheckBox ,width: .point24, height: .point24)
    private let descriptionLabel = EMLabel(font: AppTheme.medium(ofSize: .point14), textColor: AppTheme.Colors.systemBlack, text: Texts.appTitle)
    
    
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
        [checkBoxImageView, descriptionLabel].forEach { addSubview($0) }
        [checkBoxImageView, descriptionLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = .point10
        
        NSLayoutConstraint.activate([
            checkBoxImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            checkBoxImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: checkBoxImageView.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
    func configure(value: String) {
        descriptionLabel.text = value
    }
}
