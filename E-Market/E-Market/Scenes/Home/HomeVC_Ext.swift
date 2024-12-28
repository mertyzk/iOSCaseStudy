//
//  HomeVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        return item
    }
}
