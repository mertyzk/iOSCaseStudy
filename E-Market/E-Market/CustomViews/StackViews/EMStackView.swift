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
    
    convenience init(subViews: [UIView], axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode? = nil, spacing: CGFloat? = nil, distribution: UIStackView.Distribution? = nil) {
        self.init(frame: .zero)
        set(subViews: subViews, axis: axis, contentMode: contentMode, spacing: spacing, distribution: distribution)
    }
    
    
    // MARK: - Helper Functions
    private func configureStackView() {
        backgroundColor = .clear
    }
    
    
    private func set(subViews: [UIView], axis: NSLayoutConstraint.Axis, contentMode: UIView.ContentMode? = nil, spacing: CGFloat? = nil, distribution: UIStackView.Distribution? = nil) {
        self.arrangedSubviews.forEach { $0.removeFromSuperview() }
        subViews.forEach { addArrangedSubview($0) }
        self.axis             = axis
         
        if let contentMode    = contentMode {
            self.contentMode  = contentMode
        }
         
        if let spacing        = spacing {
            self.spacing      = spacing
        }
        
        if let distribution   = distribution {
            self.distribution = distribution
        }
    }
}
