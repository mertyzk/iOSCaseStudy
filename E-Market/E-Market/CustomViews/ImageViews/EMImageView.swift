//
//  EMImageView.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

/// E-Market ImageView
final class EMImageView: UIImageView {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.init(frame: .zero)
        set(image: image, width: width, height: height)
    }
    
    
    // MARK: - Helper Functions
    private func configureImageView() {
        backgroundColor = .clear
    }
    
    private func set(image: UIImage? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        if let image = image {
            self.image                                                     = image
        }
        
        self.clipsToBounds                                                 = true
        self.layer.masksToBounds                                           = true
        self.contentMode                                                   = .scaleAspectFill
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive   = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
