//
//  ProfileVM.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import Foundation

final class ProfileViewModel {
    // MARK: - Properties
    private(set) var urlString: String
    
    
    // MARK: - Initializer
    init(urlString: String) {
        self.urlString = urlString
    }
    
    
    // MARK: - Helper Functions
    func getURL() -> URL? {
        return URL(string: urlString)
    }
    
    
    func isValidURL() -> Bool {
        return getURL() != nil
    }
}
