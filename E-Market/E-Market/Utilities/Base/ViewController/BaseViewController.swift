//
//  BaseVC.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
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
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeEmptyStateView(from: view)
    }
    
    
    // MARK: - Helper Functions
    private func configureNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppTheme.Colors.navBlue
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: AppTheme.bold(ofSize: .point24)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        if navigationController?.viewControllers.count ?? 0 <= 1 {
            let titleLabel = UILabel()
            titleLabel.text = self.title?.isEmpty == false ? self.title : Texts.appTitle
            titleLabel.textColor = AppTheme.Colors.systemWhite
            titleLabel.font = AppTheme.bold(ofSize: .point24)
            titleLabel.sizeToFit()
            
            let leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            navigationItem.leftBarButtonItem = leftBarButtonItem
        } else {
            let backButton = UIBarButtonItem(image: Images.backIcon, style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.tintColor = .white
            
            navigationItem.leftBarButtonItem = backButton
            self.title = self.title?.isEmpty == false ? self.title : Texts.appTitle
        }
    }
    
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = AppTheme.Colors.navBlue
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EMEmptyStateView(message: message)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func removeEmptyStateView(from view: UIView) {
        for subview in view.subviews {
            if subview is EMEmptyStateView {
                subview.removeFromSuperview()
                break
            }
        }
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
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
