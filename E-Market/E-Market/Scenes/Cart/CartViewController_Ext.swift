//
//  CartVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.reuseID) as? CartCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let product = viewModel.cartItems[indexPath.row]

        cell.configure(with: product)
        
        cell.decreaseButtonPressed = { [weak self] product in
            guard let self else { return }
            guard let product else { return }
            viewModel.decreaseItemQuantity(product: product)
        }
        
        cell.increaseButtonPressed = { [weak self] product in
            guard let self else { return }
            guard let product else { return }
            viewModel.increaseItemQuantity(product: product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .heightForRowAt
    }
}
