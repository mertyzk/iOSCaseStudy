//
//  HomeVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeVC: BaseVC, AlertManager {
    
    // MARK: - Properties
    private let sView = HomeView()
    let viewModel = HomeVM()
    
    
    // MARK: - DeInitializer
    deinit {
        
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureCollectionView()
        configureData()
        configureActions()
    }
    
    
    // MARK: - Helper Functions
    private func configureCollectionView() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
    }
    
    
    private func configureData() {
        viewModel.fetchProducts()
        viewModel.onFetchCompletion = { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.sView.collectionView.reloadAtMainThread()
            case .failure(let error):
                self.showAlert(title: AlertConstants.errorTitle, message: error.rawValue, type: .confirm) { }
            }
        }
    }
    
    
    private func configureActions() {
        sView.filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
    }
    
    
    // MARK: - @Actions
    @objc private func filterButtonAction() {
        let filtrOpt = viewModel.configureFilterOptions()
        let filterVM = FilterVM(filterSelections: filtrOpt, sortSelections: viewModel.sortSelections, selectedFilters: viewModel.selectedFilters, selectedSort: viewModel.selectedSortOption?.rawValue)
        let nav = UINavigationController(rootViewController: FilterVC(viewModel: filterVM))
        navigationController?.show(nav, sender: nil)
    }
}
