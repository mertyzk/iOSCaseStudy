//
//  EMStackView.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

/// E-Market  Stack View
final class EMStackView: UIStackView {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Convenience Initializer
    /// - Parameters:
    ///   - subViews: arrangedSubviews
    ///   - axis: Axis (Horizontal or Vertical)
    ///   - contentMode: UIView Content Mode
    ///   - spacing: Optional argument
    convenience init(subViews: [UIView], axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode, spacing: CGFloat? = nil) {
        self.init(frame: .zero)
        set(subViews: subViews, axis: axis, contentMode: contentMode, spacing: spacing)
    }
    
    
    // MARK: - Helper Functions
    private func configureStackView() {
        backgroundColor = .clear
    }
    
    
    private func set(subViews: [UIView], axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode, spacing: CGFloat? = nil) {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        subViews.forEach { addArrangedSubview($0) }
        self.axis           = axis
        self.contentMode    = contentMode
        if let spacing      = spacing {
            self.spacing    = spacing
        }
    }
}
