//
//  FilterVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

// MARK: - UISearchBarDelegate
extension FilterVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        switch searchBar.tag {
        case 1: // Brands
            viewModel.filteredBrands = searchText.isEmpty ? viewModel.filterOptions.brands : viewModel.filterOptions.brands.filter { $0.lowercased().contains(searchText.lowercased()) }
        case 2: // Models
            viewModel.filteredModels = searchText.isEmpty ? viewModel.filterOptions.models : viewModel.filterOptions.models.filter { $0.lowercased().contains(searchText.lowercased()) }
        default:
            break
        }
        sView.tableView.reloadAtMainThread()
    }
}


// MARK: - UITableViewDataSource
extension FilterVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionTitles.count
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
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitles[section]
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = AppTheme.Colors.systemWhite
            header.textLabel?.textColor = AppTheme.Colors.systemBlack.withAlphaComponent(0.5)
            header.textLabel?.font = AppTheme.medium(ofSize: 12)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        
        let divider = UIView()
        divider.backgroundColor = AppTheme.Colors.systemBlack
        divider.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 0.5),
            divider.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            divider.topAnchor.constraint(equalTo: footerView.topAnchor),
            divider.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
        ])
        
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let headerView = UIView()
            headerView.backgroundColor = AppTheme.Colors.systemWhite
            
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            headerView.addSubview(scrollView)
            
            let contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search \(viewModel.sectionTitles[section])"
            searchBar.delegate = self
            searchBar.backgroundColor = AppTheme.Colors.systemWhite
            searchBar.tag = section
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.backgroundImage = UIImage()
            
            headerView.addSubview(searchBar)
            
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                scrollView.topAnchor.constraint(equalTo: headerView.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.widthAnchor.constraint(equalTo: headerView.widthAnchor),

                searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                searchBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
            
            return headerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : 50
    }
}
