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
    var filterSelections: [[String: [String]]]
    var selectedSort: String?
    var selectedFilter: [String: [String]] = [:]
    var sortSelections: [String]
    var searchResults: [[String: [String]]]
    
    weak var delegate: Filterable?
    
    
    // MARK: - Initializer
    init(filterSelections: [[String: [String]]], sortSelections: [String], selectedFilters: [String: [String]], selectedSort: String?) {
        self.filterSelections = filterSelections
        self.sortSelections = sortSelections
        self.selectedFilter = selectedFilters
        self.selectedSort = selectedSort
        self.searchResults = filterSelections
    }

    
    // MARK: - Helper Functions
    func numberOfRows(for section: Int) -> Int {
        if section == .zero {
            return sortSelections.count
        } else {
            return searchResults[section - 1].values.first?.count ?? .zero
        }
    }
    
    
    func selection(at indexPath: IndexPath) -> String {
        if indexPath.section == .zero {
            return sortSelections[indexPath.row]
        } else {
            let sectionIndex = indexPath.section - 1
            guard sectionIndex < searchResults.count else { return "" }
            let section = searchResults[sectionIndex]
            let values = section.values.first ?? []
            guard indexPath.row < values.count else { return "" }
            return values[indexPath.row]
        }
    }
    
    
    func isSelected(at indexPath: IndexPath) -> Bool {
        if indexPath.section == .zero {
            return sortSelections[indexPath.row] == selectedSort
        } else {
            let filter = searchResults[indexPath.section - 1]
            let filterKey = filter.keys.first!
            let filterValues = filter[filterKey]!
            return selectedFilter[filterKey]?.contains(filterValues[indexPath.row]) ?? false
        }
    }
    
    
    func selectOption(at indexPath: IndexPath) {
        if indexPath.section == .zero {
            selectedSort = sortSelections[indexPath.row]
        } else {
            let filter = searchResults[indexPath.section - 1]
            let filterKey = filter.keys.first!
            let filterValues = filter[filterKey]!
            
            var selectedValues = selectedFilter[filterKey] ?? []
            let selectedValue = filterValues[indexPath.row]
            
            if let index = selectedValues.firstIndex(of: selectedValue) {
                selectedValues.remove(at: index)
            } else {
                selectedValues.append(selectedValue)
            }
            
            if selectedValues.isEmpty {
                selectedFilter.removeValue(forKey: filterKey)
            } else {
                selectedFilter[filterKey] = selectedValues
            }
        }
    }

    
    func searchFilter(for text: String, in section: Int) {
        if text.isEmpty {
            searchResults = filterSelections
        } else {
            searchResults = filterSelections.enumerated().map { index, filter in
                var newFilter = filter
                if index == section - 1 {
                    let key = filter.keys.first!
                    newFilter[key] = filter[key]?.filter { $0.lowercased().contains(text.lowercased()) }
                }
                return newFilter
            }
        }
    }
}
