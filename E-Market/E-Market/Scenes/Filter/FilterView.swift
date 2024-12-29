//
//  FilterView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterView: UIView {
    
    // MARK: - UI Elements
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = AppTheme.Colors.systemWhite
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.isScrollEnabled = false
        return tv
    }()
    let applyFilt = EMButton(font: AppTheme.bold(ofSize: 22), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.filterText, height: 38, cornerRadius: 4)
    

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        [tableView, applyFilt].forEach { addSubview($0) }
        [tableView, applyFilt].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            applyFilt.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            applyFilt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            applyFilt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: applyFilt.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: applyFilt.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: applyFilt.topAnchor)
        ])
    }
}
