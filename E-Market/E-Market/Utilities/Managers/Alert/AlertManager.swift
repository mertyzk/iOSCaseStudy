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
                alertController.addAction(UIAlertAction(title: AlertType.confirm.title, style: .default, handler: { _ in
                    completion()
                }))
            case .cancel:
                alertController.addAction(UIAlertAction(title: AlertType.confirm.title, style: .default, handler: { _ in
                    completion()
                }))
                alertController.addAction(UIAlertAction(title: AlertType.cancel.title, style: .destructive, handler: nil))
            case .goToCart:
                alertController.addAction(UIAlertAction(title: AlertType.goToCart.title, style: .default, handler: { _ in
                    completion()
                }))
                
                alertController.addAction(UIAlertAction(title: AlertType.cancel.title, style: .destructive, handler: nil))
                
            case .approve:
                alertController.addAction(UIAlertAction(title: AlertType.approve.title, style: .default, handler: { _ in
                    completion()
                }))
                
                alertController.addAction(UIAlertAction(title: AlertType.cancel.title, style: .destructive, handler: nil))
            }
            
            self.present(alertController, animated: true)
        }
    }
}
