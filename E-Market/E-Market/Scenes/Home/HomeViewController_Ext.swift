//
//  HomeVC_Ext.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.reuseID, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        
        item.onTapCell = { [weak self] product in
            guard let self else { return }
            let detailVM      = DetailsViewModel(product: product, cartManager: CartStore())
            let destinationVC = DetailsViewController(viewModel: detailVM)
            navigationController?.pushViewController(destinationVC, animated: false)
        }
        
        guard let product = viewModel.product(for: indexPath.row) else { return item }
        item.configureData(with: product, isFavorite: viewModel.isProductFavorite(for: product))
        
        item.favoriteButtonTapped = { [weak self] product in
            guard let self else { return }
            guard let product else { return }
            
            let isFavorite = viewModel.isProductFavorite(for: product)
            
            guard !isFavorite else {
                self.showAlert(title: AlertConstants.alreadyFavorite, message: AlertConstants.alreadyFavoriteDescription, type: .confirm) {}
                return
            }
            
            viewModel.addToFavorite(product: product) { error in
                guard error == nil else {
                    self.showAlert(title: AlertConstants.generalErrorTitle, message: error!.rawValue, type: .confirm) {}
                    return
                }
                self.showAlert(title: AlertConstants.successFavoriteTitle, message: AlertConstants.succesFavoriteDescription, type: .confirm) {
                    self.sView.collectionView.reloadAtMainThread()
                }
            }
        }
        
        item.addToCartButtonTapped = { [weak self] product in
            guard let self else { return }
            guard let product else { return }
            viewModel.addToCart(product: product) { error in
                guard error == nil else {
                    self.showAlert(title: AlertConstants.generalErrorTitle, message: error!.rawValue, type: .confirm) {}
                    return
                }
                self.showAlert(title: AlertConstants.successCartTitle, message: AlertConstants.successCartDescription, type: .confirm) {}
            }
        }
        return item
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if offsetY >= contentHeight - frameHeight - 10 {
            viewModel.fetchProducts()
        }
    }
}


// MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterContentForSearchText(searchText) { [weak self] in
            guard let self else { return }
            self.sView.collectionView.reloadAtMainThread()
        }
    }
}
