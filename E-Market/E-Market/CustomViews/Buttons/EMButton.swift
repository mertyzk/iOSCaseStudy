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
    
    /// Convenience Initializer
    /// - Parameters:
    ///   - font: ThemeFont type
    ///   - textColor: ThemeColor type
    ///   - text: String value
    ///   - bgColor: Button background color
    convenience init(font: UIFont, textColor: UIColor, bgColor: UIColor, text: String) {
        self.init(frame: .zero)
        set(font: font, textColor: textColor, bgColor: bgColor, text: text)
    }
    
    
    // MARK: - Helper Functions
    private func configure() {
        backgroundColor  = .clear
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func set(font: UIFont, textColor: UIColor, bgColor: UIColor, text: String) {
        titleLabel?.font = font
        backgroundColor  = bgColor
        setTitleColor(textColor, for: .normal)
        setTitle(text, for: .normal)
    }
}
