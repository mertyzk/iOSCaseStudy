//
//  Constants.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

// MARK: - ScreenSize
enum ScreenSize {
    static let width           = UIScreen.main.bounds.size.width
    static let height          = UIScreen.main.bounds.size.height
    static let maxLength       = max(ScreenSize.width, ScreenSize.height)
    static let minLength       = min(ScreenSize.width, ScreenSize.height)
}
        
        
// MARK: - Images
enum Images {
    static let emptyStar       = UIImage(named: "emptyStar")?.withRenderingMode(.alwaysOriginal)
    static let filledStar      = UIImage(named: "filledStar")?.withRenderingMode(.alwaysOriginal)
    static let backIcon        = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
    static let closeIcon       = UIImage(named: "closeIcon")?.withRenderingMode(.alwaysOriginal)
    static let searchIcon      = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysOriginal)
    static let homeIcon        = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysOriginal)
    static let basketIcon      = UIImage(named: "basketIcon")?.withRenderingMode(.alwaysOriginal)
    static let starIcon        = UIImage(named: "starIcon")?.withRenderingMode(.alwaysOriginal)
    static let personIcon      = UIImage(named: "personIcon")?.withRenderingMode(.alwaysOriginal)
    static let emptyCheckBox   = UIImage(named: "emptyCheckBox")?.withRenderingMode(.alwaysOriginal)
    static let filledCheckBox  = UIImage(named: "filledCheckBox")?.withRenderingMode(.alwaysOriginal)
    static let emptyCircle     = UIImage(named: "emptyCircle")?.withRenderingMode(.alwaysOriginal)
    static let filledCircle    = UIImage(named: "filledCircle")?.withRenderingMode(.alwaysOriginal)
}
        
        
// MARK: - Texts
enum Texts {
    static let search          = "Search"
    static let filters         = "Filters:"
    static let selectFilter    = "Select Filter"
    static let addToCart       = "Add to Cart"
    static let price           = "Price"
    static let total           = "Total"
    static let totalCart       = "Total: "
    static let complete        = "Complete"
    static let priceText       = "15.000 ₺"
    static let titleText       = "iPhone 13 Pro Max 256Gb"
    static let appTitle        = "E-Market"
    static let tlIconText      = "₺"
    static let plusButton      = "+"
    static let minusButton     = "-"
    static let favorites       = "Favorites"
    static let filterText      = "Filter"
    static let sortHeader      = "Sort By"
    static let entity404       = "Entity not found"
    static let noDataFound     = "Sorry, no data found to show."
    static let purchaseError   = "Something went wrong at the moment of purchase."
}


// MARK: - SystemImages
enum SystemImages {
    static let magnifyingglass = "magnifyingglass"
}
