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
    
    /// Convenience Initializer
    /// - Parameters:
    ///   - font: ThemeFont type
    ///   - textColor: ThemeColor type
    ///   - text: String value
    convenience init(font: UIFont, textColor: UIColor, text: String) {
        self.init(frame: .zero)
        set(font: font, textColor: textColor, text: text)
    }
    
    
    // MARK: - Helper Functions
    private func configureUILabel() {
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 20)
    }
    
    private func set(font: UIFont, textColor: UIColor, text: String) {
        self.textColor  = textColor
        self.font       = font
        self.text       = text
    }
}
