//
//  BaseVC.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

class BaseVC: UIViewController {
    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Initializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        configureNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(showLoading), name: .showLoading, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideLoading), name: .hideLoading, object: nil)
    }
    
    
    // MARK: - Helper Functions
    private func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.Colors.navBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: AppTheme.bold(ofSize: 24)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        let titleLabel = UILabel()
        titleLabel.text = self.title?.isEmpty == false ? self.title : Texts.appTitle
        titleLabel.textColor = AppTheme.Colors.systemWhite
        titleLabel.font = AppTheme.bold(ofSize: 24)
        titleLabel.sizeToFit()
        
        let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = AppTheme.Colors.navBlue
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: self.view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
          ])
    }
    
    
    // MARK: - @Actions
    @objc func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.activityIndicator?.startAnimating()
        }
    }
    
    @objc func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.activityIndicator?.stopAnimating()
        }
    }
}
