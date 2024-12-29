//
//  HomeVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        item.delegate = self
        guard let product = viewModel.product(for: indexPath.row) else { return item }
        item.configureData(with: product, isFavorite: true)
        return item
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let product = viewModel.product(for: indexPath.row) else { return }
        let detailVM      = DetailsVM(product: product)
        let destinationVC = DetailsVC(viewModel: detailVM)
        navigationController?.pushViewController(destinationVC, animated: false)
    }
}


// MARK: - HomeCellProtocol
extension HomeVC: HomeCellProtocol {
    func favoriteButtonTapped(product: Product) {
        print("xxxxxxxxxxx DEBUG: favoriteButtonTapped")
    }
    
    
    func addToCartButtonTapped(product: Product) {
        print("xxxxxxxxxxx DEBUG: addToCartButtonTapped")
    }
    
    
}
