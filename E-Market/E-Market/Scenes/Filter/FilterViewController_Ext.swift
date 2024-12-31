//
//  FilterVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

// MARK: - UISearchBarDelegate
extension FilterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.accessibilityIdentifier == SearchbarAccessibility.brandSearchBar.rawValue {
            viewModel.filterBrands(searchText: searchText) { [weak self] in
                guard let self else { return }
                self.sView.brandTableView.reloadAtMainThread()
            }
          
        } else {
            viewModel.filterModels(searchText: searchText) { [weak self] in
                guard let self else { return }
                self.sView.modelTableView.reloadAtMainThread()
            }
 
        }
    }
}


// MARK: - UITableViewDataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sView.sortTableView {
            return SortingOptions.allCases.count
        } else if tableView == sView.brandTableView {
            return viewModel.filteredBrands.count
        } else {
            return viewModel.filteredModels.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sView.sortTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterCell.reuseID, for: indexPath) as? SortFilterCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(sortingOption: SortingOptions.allCases[indexPath.row])
            return cell
        } else if tableView == sView.brandTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BrandFilterCell.reuseID, for: indexPath) as? BrandFilterCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(value: viewModel.getBrands(for: indexPath))
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ModelFilterCell.reuseID, for: indexPath) as? ModelFilterCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.configure(value: viewModel.getModels(for: indexPath))
            return cell
        }
    }
}


// MARK: - UITableViewDelegate
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sView.sortTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? SortFilterCell else { return }
            cell.circleImageView.image = Images.filldCircl
            viewModel.filterData.selectedSortOption = SortingOptions.allCases[indexPath.row]
        } else if tableView == sView.brandTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? BrandFilterCell else { return }
            
            let selectedBrand = viewModel.filter.brands[indexPath.row]
            
            if viewModel.filterData.selectedBrands.contains(selectedBrand) {
                cell.checkBoxImageView.image = Images.emptyCheck
                viewModel.filterData.selectedBrands.removeAll { $0 == selectedBrand }
            } else {
                cell.checkBoxImageView.image = Images.filldCheck
                viewModel.filterData.selectedBrands.append(selectedBrand)
            }
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) as? ModelFilterCell else { return }
            
            let selectedModel = viewModel.filter.models[indexPath.row]
            
            if viewModel.filterData.selectedModels.contains(selectedModel) {
                cell.checkBoxImageView.image = Images.emptyCheck
                viewModel.filterData.selectedBrands.removeAll { $0 == selectedModel }
            } else {
                cell.checkBoxImageView.image = Images.filldCheck
                viewModel.filterData.selectedModels.append(selectedModel)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == sView.sortTableView {
            guard let cell = tableView.cellForRow(at: indexPath) as? SortFilterCell else { return }
            cell.circleImageView.image = Images.emptyCircl
        }
    }
}
