//
//  FilterVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

// MARK: - UITableViewDataSource
extension FilterVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return viewModel.staticSorting.count
        case 1: return viewModel.filterOptions.brands.count
        case 2: return viewModel.filterOptions.models.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = viewModel.staticSorting[indexPath.row]
            cell.accessoryType = viewModel.selectedSort == indexPath.row ? .checkmark : .none
        case 1:
            cell.textLabel?.text = viewModel.filterOptions.brands[indexPath.row]
            cell.accessoryType = viewModel.selectedBrands.contains(viewModel.filterOptions.brands[indexPath.row]) ? .checkmark : .none
        case 2:
            cell.textLabel?.text = viewModel.filterOptions.models[indexPath.row]
            cell.accessoryType = viewModel.selectedModels.contains(viewModel.filterOptions.models[indexPath.row]) ? .checkmark : .none
        default:
            break
        }
        return cell
    }
}


// MARK: - UITableViewDelegate
extension FilterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            viewModel.selectedSort = indexPath.row
        case 1:
            let brand = viewModel.filterOptions.brands[indexPath.row]
            if viewModel.selectedBrands.contains(brand) {
                viewModel.selectedBrands.removeAll { $0 == brand }
            } else {
                viewModel.selectedBrands.append(brand)
            }
        case 2:
            let model = viewModel.filterOptions.models[indexPath.row]
            if viewModel.selectedModels.contains(model) {
                viewModel.selectedModels.removeAll { $0 == model }
            } else {
                viewModel.selectedModels.append(model)
            }
        default:
            break
        }
        tableView.reloadData()
    }
}
