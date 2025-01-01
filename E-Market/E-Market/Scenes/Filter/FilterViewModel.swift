//
//  FilterVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterViewModel {
    
    // MARK: - Properties
    var filter: Filter
    
    var filteredBrands: [String] = []
    var filteredModels: [String] = []
    
    var filterData = FilterData(
        selectedSortOption: nil,
        selectedBrands: [],
        selectedModels: []
    )
    
    
    // MARK: - Initializer
    init(filter: Filter) {
        self.filter = filter
        filteredBrands = filter.brands
        filteredModels = filter.models
    }
    
    
    // MARK: - Helper Functions
    func getBrands(for indexPath: IndexPath) -> String {
        return filteredBrands[indexPath.row]
    }
    
    
    func getModels(for indexPath: IndexPath) -> String {
        return filteredModels[indexPath.row]
    }
    
    
    func filterBrands(searchText: String, completion: @escaping () -> ()) {
        if searchText.isEmpty {
            filteredBrands = filter.brands
        } else {
            filteredBrands = filter.brands.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        completion()
    }
    
    
    func filterModels(searchText: String, completion: @escaping () -> ()) {
        if searchText.isEmpty {
            filteredModels = filter.models
        } else {
            filteredModels = filter.models.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        completion()
    }
}
