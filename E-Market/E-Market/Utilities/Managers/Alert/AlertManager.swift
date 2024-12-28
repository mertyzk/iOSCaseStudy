//
//  AlertManager.swift
//  E-Market
//
//  Created by Macbook Air on 28.12.2024.
//

import UIKit

protocol AlertManager where Self: UIViewController {
    func showAlert(title: String, message: String, type: AlertType, completion: @escaping (() ->()))
}


extension AlertManager {
    func showAlert(title: String, message: String, type: AlertType, completion: @escaping (() ->())) {
        DispatchQueue.main.async { [weak self] in
            
            guard let self else { return }
            
            if self.presentedViewController is UIAlertController {
                return
            }
            
            let alertController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            
            switch type {
            case .confirm:
                alertController.addAction(UIAlertAction(title: AlertType.confirm.title, style: UIAlertAction.Style.default, handler: nil))
            case .sure:
                alertController.addAction(UIAlertAction(title: AlertType.confirm.title, style: UIAlertAction.Style.default, handler: { _ in
                    completion()
                }))
                alertController.addAction(UIAlertAction(title: AlertType.sure.title, style: UIAlertAction.Style.default, handler: nil))
            }
            
            self.present(alertController, animated: true)
        }
    }
}
