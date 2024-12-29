//
//  FilterSelectCell.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

final class FilterSelectCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseID    = "FilterSelectCell"
    
    
    // MARK: - UI Elements
    private let circleImageView  = EMImageView(width: 24, height: 24)
    private let descriptionLabel = EMLabel(font: AppTheme.medium(ofSize: 14), textColor: AppTheme.Colors.systemBlack, text: Texts.appTitle)
    
    
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
        [circleImageView, descriptionLabel].forEach { addSubview($0) }
        [circleImageView, descriptionLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            circleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            circleImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
    func configureCell(with selection: String, isSelected: Bool) {
        descriptionLabel.text = selection
        circleImageView.image = UIImage(systemName: isSelected ? SystemImages.filledCBox : SystemImages.checkBox)
    }
}
