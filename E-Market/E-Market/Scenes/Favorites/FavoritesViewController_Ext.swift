//
//  FavoritesVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favoriteProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        
        item.onTapCell = { [weak self] product in
            guard let self else { return }
            let detailVM      = DetailsViewModel(product: product, cartManager: CartStore())
            let destinationVC = DetailsViewController(viewModel: detailVM)
            navigationController?.pushViewController(destinationVC, animated: false)
        }
        
        item.configureData(with: viewModel.favoriteProducts[indexPath.row])
        
        item.unFavoriteButtonTapped = { [weak self] product in
            guard let self else { return }
            guard let product else { return }
            
            self.showAlert(title: AlertConstants.areYouSureTitle, message: AlertConstants.sureDescription, type: .cancel) {
                self.viewModel.deleteProductFromLocalDB(for: product)
            }
        }
        
        item.onTapCell = { [weak self] product in
            guard let self else { return }
            let detailVM      = DetailsViewModel(product: product, cartManager: CartStore())
            let destinationVC = DetailsViewController(viewModel: detailVM)
            navigationController?.pushViewController(destinationVC, animated: false)
        }
        
        return item
    }
}
