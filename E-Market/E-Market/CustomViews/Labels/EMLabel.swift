//
//  EMLabel.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

/// E-Market  Label
final class EMLabel: UILabel {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUILabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(font: UIFont, textColor: UIColor, text: String, bgColor: UIColor? = nil, width: CGFloat? = nil, height: CGFloat? = nil, textAlignment: NSTextAlignment? = nil) {
        self.init(frame: .zero)
        set(font: font, textColor: textColor, text: text, bgColor: bgColor, width: width, height: height, textAlignment: textAlignment)
    }
    
    
    // MARK: - Helper Functions
    private func configureUILabel() {
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 20)
    }
    
    private func set(font: UIFont, textColor: UIColor, text: String, bgColor: UIColor? = nil, width: CGFloat? = nil, height: CGFloat? = nil, textAlignment: NSTextAlignment? = nil) {
        self.textColor           = textColor
        self.font                = font
        self.text                = text
        self.numberOfLines       = 0
        
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        
        if let bgColor = bgColor {
            self.backgroundColor = bgColor
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
