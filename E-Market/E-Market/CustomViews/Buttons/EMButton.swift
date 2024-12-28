//
//  EMButton.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

/// E-Market  Button
final class EMButton: UIButton {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(font: UIFont, textColor: UIColor, bgColor: UIColor, text: String, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        self.init(frame: .zero)
        set(font: font, textColor: textColor, bgColor: bgColor, text: text, width: width, height: height, cornerRadius: cornerRadius)
    }
    
    
    // MARK: - Helper Functions
    private func configure() {
        backgroundColor  = .clear
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func set(font: UIFont, textColor: UIColor, bgColor: UIColor, text: String, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat? = nil) {
        titleLabel?.font = font
        backgroundColor  = bgColor
        setTitleColor(textColor, for: .normal)
        setTitle(text, for: .normal)
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive   = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
    }
}
