//
//  AlertType.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

enum AlertType {
    case confirm
    case cancel
    case goToCart
    case approve
}


extension AlertType {
    var title: String {
        switch self {
        case .confirm:
            return "Confirm"
        case .cancel:
            return "Cancel"
        case .goToCart:
            return "Go to your cart"
        case .approve:
            return "Approve"
        }
    }
}
