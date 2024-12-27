//
//  AppTheme.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

struct AppTheme {
    
    // MARK: - Theme Colors
    enum Colors {
        static let navBlue     = UIColor(hexString: "2A59FE")
        static let filterGray  = UIColor(hexString: "D9D9D9")
        static let systemWhite = UIColor(hexString: "FFFFFF")
    }
    
    
    // MARK: - Theme Fonts
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: size)
    }
}
