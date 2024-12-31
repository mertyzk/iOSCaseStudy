//
//  EMSearchBar.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

final class EMSearchBar: UISearchBar {
    
    // MARK: - Initializer
    init(frame: CGRect, accessibilityIdentifier: SearchbarAccessibility? = nil) {
        super.init(frame: .zero)
        configure(accessibilityIdentifier: accessibilityIdentifier)
        configureToolBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configure(accessibilityIdentifier: SearchbarAccessibility? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        searchBarStyle = .minimal
        searchTextField.keyboardAppearance = .default
        spellCheckingType = .no
        autocorrectionType = .no
        placeholder = Texts.search
        if let identifier = accessibilityIdentifier {
            self.accessibilityIdentifier = identifier.rawValue
        }
    }
    
    
    private func configureToolBar() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonAction))
        
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        searchTextField.inputAccessoryView = toolbar
    }
    
    
    func setDelegate(_ delegate: UISearchBarDelegate) {
        self.delegate = delegate
    }
    
    
    // MARK: - @Actions
    @objc func doneButtonAction() {
        resignFirstResponder()
    }
}
