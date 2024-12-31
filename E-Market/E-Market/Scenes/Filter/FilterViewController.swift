//
//  FilterVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterViewController: UIViewController {

    // MARK: - Properties
    let sView = FilterView()
    var viewModel: FilterViewModel
    
    
    // MARK: - Initializer
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Lifecycle
    override func loadView() {
        view = sView
        title = Texts.filterText
        configureBarButton()
        configureActions()
        configureTableViewsAndSearchBars()
    }
    
    
    // MARK: - Helper Functions
    private func configureBarButton() {
        let leftButton = UIBarButtonItem(image: Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem  = leftButton
    }
    
    
    private func configureActions() {
        sView.applyFilterButton.addTarget(self, action: #selector(applyFilterButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureTableViewsAndSearchBars() {
        sView.sortTableView.delegate = self
        sView.sortTableView.dataSource = self
        sView.sortTableView.register(SortFilterCell.self, forCellReuseIdentifier: SortFilterCell.reuseID)
        
        sView.brandTableView.delegate = self
        sView.brandTableView.dataSource = self
        sView.brandSearchBar.delegate = self
        sView.brandTableView.register(BrandFilterCell.self, forCellReuseIdentifier: BrandFilterCell.reuseID)
        
        sView.modelTableView.delegate = self
        sView.modelTableView.dataSource = self
        sView.modelSearchBar.delegate = self
        sView.modelTableView.register(ModelFilterCell.self, forCellReuseIdentifier: ModelFilterCell.reuseID)
    }
    
    
    // MARK: - @Actions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    
    @objc private func applyFilterButtonTapped() {
        NotificationCenter.default.post(name: .didFilter, object: viewModel.filterData)
        dismiss(animated: true)
    }
}
