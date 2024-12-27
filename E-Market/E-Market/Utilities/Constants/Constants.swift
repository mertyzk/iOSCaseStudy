//
//  Constants.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

// MARK: - ScreenSize
enum ScreenSize {
    static let width      = UIScreen.main.bounds.size.width
    static let height     = UIScreen.main.bounds.size.height
    static let maxLength  = max(ScreenSize.width, ScreenSize.height)
    static let minLength  = min(ScreenSize.width, ScreenSize.height)
}


// MARK: - Images
enum Images {
    static let emptyStar  = UIImage(named: "emptyStar")?.withRenderingMode(.alwaysOriginal)
    static let filledStar = UIImage(named: "filledStar")?.withRenderingMode(.alwaysOriginal)
    static let backIcon   = UIImage(named: "backIcon")?.withRenderingMode(.alwaysOriginal)
    static let closeIcon  = UIImage(named: "closeIcon")?.withRenderingMode(.alwaysOriginal)
    static let searchIcon = UIImage(named: "searchIcon")?.withRenderingMode(.alwaysOriginal)
    static let homeIcon   = UIImage(named: "homeIcon")?.withRenderingMode(.alwaysOriginal)
    static let basketIcon = UIImage(named: "basketIcon")?.withRenderingMode(.alwaysOriginal)
    static let starIcon   = UIImage(named: "starIcon")?.withRenderingMode(.alwaysOriginal)
    static let personIcon = UIImage(named: "personIcon")?.withRenderingMode(.alwaysOriginal)
}


// MARK: - System Images
enum SystemImages {
    static let emptyStar  = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
    static let filledStar = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
    static let backIcon   = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal)
    static let closeIcon  = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal)
    static let searchIcon = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal)
    static let homeIcon   = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
    static let basketIcon = UIImage(systemName: "basket")?.withRenderingMode(.alwaysOriginal)
    static let starIcon   = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
    static let personIcon = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)
}


// MARK: - Texts
enum Texts {
    static let pastLaunch = "Past Launch"
}
