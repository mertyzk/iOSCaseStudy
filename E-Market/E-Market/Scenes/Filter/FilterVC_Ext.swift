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
        for (index, tableView) in sView.createdTableViews.enumerated() {
            if let headerView = tableView.headerView(forSection: 0) as? FiltersSectionHeader,
               headerView.contains(searchBar: searchBar) {
                viewModel.searchFilter(for: searchText, in: index + 1)
                tableView.reloadData()
                break
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension FilterVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == sView.sortTableView {
            return viewModel.numberOfRows(for: 0)
        } else if let index = sView.createdTableViews.firstIndex(of: tableView) {
            return viewModel.numberOfRows(for: index)
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == sView.sortTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterCell.reuseID, for: indexPath) as? SortFilterCell else {
                return UITableViewCell()
            }
            let selection = viewModel.selection(at: indexPath)
            let isSelected = viewModel.isSelected(at: indexPath)
            cell.configureCell(with: selection, isSelected: isSelected)
            return cell
        } else if let index = sView.createdTableViews.firstIndex(of: tableView) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterSelectCell.reuseID, for: indexPath) as? FilterSelectCell else {
                return UITableViewCell()
            }
            let adjustedIndexPath = IndexPath(row: indexPath.row, section: index + 1)
            let selection = viewModel.selection(at: adjustedIndexPath)
            let isSelected = viewModel.isSelected(at: adjustedIndexPath)
            cell.configureCell(with: selection, isSelected: isSelected)
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: - UITableViewDelegate
extension FilterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == sView.sortTableView {
            viewModel.selectOption(at: indexPath)
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        } else if let index = sView.createdTableViews.firstIndex(of: tableView) {
            let adjustedIndexPath = IndexPath(row: indexPath.row, section: index + 1)
            viewModel.selectOption(at: adjustedIndexPath)
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
        
        guard let searchBar = (tableView.headerView(forSection: .zero) as? FiltersSectionHeader)?.searchBar else { return }
        self.searchBar(searchBar, textDidChange: "")
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FiltersSectionHeader.reuseID) as? FiltersSectionHeader else {
            return nil
        }
        let title: String
        let isSearchBarVisible: Bool
        if tableView == sView.sortTableView {
            title = Texts.sortHeader
            isSearchBarVisible = false
        } else if let index = sView.createdTableViews.firstIndex(of: tableView) {
            title = viewModel.filterSelections[index].keys.first ?? ""
            isSearchBarVisible = true
        } else {
            return nil
        }
        headerView.configure(title: title, searchBarDelegate: self, isSearchBarVisible: isSearchBarVisible)
        return headerView
    }
}
