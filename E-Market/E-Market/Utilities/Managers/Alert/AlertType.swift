//
//  AlertType.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import Foundation

enum AlertType {
    case confirm
    case sure
}


extension AlertType {
    var title: String {
        switch self {
        case .confirm:
            return "Confirm"
        case .sure:
            return "Cancel"
        }
    }
}
