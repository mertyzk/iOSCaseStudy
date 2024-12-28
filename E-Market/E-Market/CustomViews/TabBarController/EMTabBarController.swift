//
//  EMTabBarController.swift
//  E-Market
//
//  Created by Macbook Air on 27.12.2024.
//

import UIKit

class EMTabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    
    // MARK: - Helper Functions
    private func configureViewControllers() {
        let homeVC                  = configureNavigationController(rootVC: HomeVC(), image: Images.homeIcon)
        let cartVC                  = configureNavigationController(rootVC: CartVC(), image: Images.basketIcon)
        let favoritesVC             = configureNavigationController(rootVC: FavoritesVC(), image: Images.starIcon)
        let profileVC               = configureNavigationController(rootVC: ProfileVC(), image: Images.personIcon)
        
        viewControllers             = [homeVC, cartVC, favoritesVC, profileVC]
    }

    
    private func configureNavigationController(rootVC: UIViewController, image: UIImage?) -> UINavigationController {
        let navigation              = UINavigationController(rootViewController: rootVC)
        navigation.tabBarItem.image = image
        return navigation
    }
    

}
