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

    }
}


// MARK: - UITableViewDataSource
extension FilterVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
    }
}


// MARK: - UITableViewDelegate
extension FilterVC: UITableViewDelegate {

}
