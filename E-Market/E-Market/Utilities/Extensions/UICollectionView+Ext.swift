//
//  UICollectionView+Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

extension UICollectionView {
    func reloadAtMainThread() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.reloadData()
        }
    }
}
