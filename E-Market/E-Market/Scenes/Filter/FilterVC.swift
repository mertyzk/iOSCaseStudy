//
//  FilterVC.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterVC: UIViewController {

    // MARK: - Properties
    let sView = FilterView()
    var viewModel: FilterVM
    
    
    // MARK: - Initializer
    init(viewModel: FilterVM) {
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
        configureTableViews()
    }
    
    
    // MARK: - Helper Functions
    private func configureBarButton() {
        let leftButton = UIBarButtonItem(image: Images.closeIcon, style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem  = leftButton
    }
    
    
    private func configureTableViews() {
        sView.sortTableView.delegate = self
        sView.sortTableView.dataSource = self
        sView.sortTableView.register(SortFilterCell.self, forCellReuseIdentifier: SortFilterCell.reuseID)
        sView.createdTableViews.forEach { tv in
            tv.delegate = self
            tv.dataSource = self
            tv.register(FilterSelectCell.self, forCellReuseIdentifier: FilterSelectCell.reuseID)
            tv.register(FiltersSectionHeader.self, forHeaderFooterViewReuseIdentifier: FiltersSectionHeader.reuseID)
        }
    }
    
    
    // MARK: - @Actions
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
