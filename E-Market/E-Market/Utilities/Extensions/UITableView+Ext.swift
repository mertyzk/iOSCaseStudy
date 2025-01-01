//
//  UITableView+Ext.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit

extension UITableView {
    func reloadAtMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
    }
}
