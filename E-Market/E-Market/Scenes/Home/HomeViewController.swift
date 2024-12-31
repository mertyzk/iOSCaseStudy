//
//  HomeVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class HomeViewController: BaseViewController, AlertManager {
    
    // MARK: - Properties
    let sView = HomeView()
    var viewModel: HomeViewModel
    
    
    // MARK: - DeInitializer
    deinit {
        NotificationCenter.default.removeObserver(self, name: .favUpdated, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didFilter, object: nil)
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        configureCollectionViewAndSearchBar()
        configureData()
        configureActions()
        configureNotificationObservers()
    }
    

    // MARK: - Helper Functions
    private func configureCollectionViewAndSearchBar() {
        sView.collectionView.delegate = self
        sView.collectionView.dataSource = self
        sView.searchBar.delegate = self
        sView.collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.reuseID)
    }
    
    
    private func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdated), name: .favUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(makeFilter(_:)), name: .didFilter, object: nil)
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
        let filterOp = viewModel.configureFilterOptions()
        let filterVM = FilterViewModel(filter: filterOp)
        let nav = UINavigationController(rootViewController: FilterViewController(viewModel: filterVM))
        navigationController?.show(nav, sender: nil)
    }
    
    
    @objc private func favoritesUpdated() {
        viewModel.fetchProducts()
    }
    
    
    @objc private func makeFilter(_ notification: Notification) {
        if let selectedFilters = notification.object as? FilterData {
            viewModel.makeFilter(selectedFilters: selectedFilters) { [weak self] in
                guard let self else { return }
                self.sView.collectionView.reloadAtMainThread()
            }
        }
    }
}
