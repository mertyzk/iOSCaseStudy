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
    var filterOptions: Filter
    let staticSorting = ["Old to new", "New to old", "Price high to low", "Price low to High"]
    var selectedSort: Int? = nil
    var selectedBrands: [String] = []
    var selectedModels: [String] = []
    
    weak var delegate: Filterable?
    
    
    // MARK: - Initializer
    init(filterOptions: Filter) {
        self.filterOptions = filterOptions
        print("xxxxxxxxxxx DEBUG: \(filterOptions)")
    }
    
    
    // MARK: - Helper Functions
    func applyFilter() {
        
    }
    
    
    
    
    
    

}
