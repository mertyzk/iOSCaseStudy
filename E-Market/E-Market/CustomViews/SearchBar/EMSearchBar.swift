//
//  EMSearchBar.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

class EMSearchBar: UISearchBar {
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        configureToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        searchBarStyle = .minimal
        searchTextField.keyboardAppearance = .default
        spellCheckingType = .no
        autocorrectionType = .no
        placeholder = Texts.search
    }
    
    
    private func configureToolBar() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        searchTextField.inputAccessoryView = toolbar
    }
    
    
    @objc func doneButtonAction() {
        resignFirstResponder()
    }
}
