//
//  FilterVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

protocol Filterable: AnyObject {
    func filterApplied(products: [Product])
}


final class FilterVM {
    
    // MARK: - Properties
    weak var delegate: Filterable?
    
    
    // MARK: - Initializer

    
    // MARK: - Helper Functions
}
