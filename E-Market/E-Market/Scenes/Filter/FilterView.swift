//
//  FilterView.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

final class FilterView: UIView {
    
    // MARK: - UI Elements
    lazy var sortTableView: UITableView = {
        let tv = tableViewCreator()
        tv.isScrollEnabled = false
        return tv
    }()
    
    lazy var seperatorLine: UIView = {
        let line = seperatorCreator()
        return line
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.backgroundColor = .white.withAlphaComponent(0.5)
        return stackView
    }()
    
    let applyFilt = EMButton(font: AppTheme.bold(ofSize: 22), textColor: AppTheme.Colors.systemWhite, bgColor: AppTheme.Colors.navBlue, text: Texts.filterText, height: 38, cornerRadius: 4)
    
    var createdTableViews: [UITableView] = []
    
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureUI()
        configureDynamicTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        [sortTableView, seperatorLine, stackView, applyFilt].forEach { addSubview($0) }
        [stackView, applyFilt].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            applyFilt.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            applyFilt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            applyFilt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            sortTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding),
            sortTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            sortTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            sortTableView.heightAnchor.constraint(equalToConstant: 179),
            
            seperatorLine.topAnchor.constraint(equalTo: sortTableView.bottomAnchor, constant: padding),
            seperatorLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            seperatorLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
            
            stackView.topAnchor.constraint(equalTo: seperatorLine.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            applyFilt.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            applyFilt.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            applyFilt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            applyFilt.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func tableViewCreator() -> UITableView {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = AppTheme.Colors.systemWhite
        tv.alwaysBounceVertical = false
        tv.bounces = false
        tv.showsVerticalScrollIndicator = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        return tv
    }
    
    
    private func seperatorCreator() -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = AppTheme.Colors.systemBlack.withAlphaComponent(0.5)
        return v
    }
    
    
    private func configureDynamicTableView() {
        for _ in 0..<2 {
            _      = seperatorCreator()
            let tv = tableViewCreator()
            createdTableViews.append(tv)
            stackView.addArrangedSubview(tv)
        }
    }
}
