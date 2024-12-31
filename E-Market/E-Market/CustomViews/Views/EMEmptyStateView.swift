//
//  EMEmptyStateView.swift
//  E-Market
//
//  Created by Macbook Air on 31.12.2024.
//

import UIKit

class EMEmptyStateView: UIView {
    
    let messageLabel = EMLabel(font: AppTheme.medium(ofSize: .point24), textColor: AppTheme.Colors.navBlue, text: "")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {

        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        configureMessageLabel()

    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines      = 2
        messageLabel.textColor          = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}
