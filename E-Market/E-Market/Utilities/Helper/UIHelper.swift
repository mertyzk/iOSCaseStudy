//
//  UIHelper.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

enum UIHelper {
    static func createColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width: CGFloat                 = ScreenSize.width
        let padding: CGFloat               = 16
        let minimumItemSpacing: CGFloat    = 21
        let minimumLineSpacing: CGFloat    = 14
         
        let availableWidth: CGFloat        = width - (padding * 2) - minimumItemSpacing
        let itemWidth: CGFloat             = availableWidth / 2
         
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.scrollDirection         = .vertical
        flowLayout.sectionInset            = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.minimumLineSpacing      = minimumLineSpacing
        flowLayout.itemSize                = CGSize(width: itemWidth, height: itemWidth + 133)
        
        return flowLayout
    }
}
