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
        let homeVM                  = HomeVM(favoriteManager: FavoriteStore(), cartManager: CartStore())
        let homeVC                  = configureNavigationController(rootVC: HomeVC(viewModel: homeVM), image: Images.homeIcon)
        let cartVM                  = CartVM(cartManager: CartStore())
        let cartVC                  = configureNavigationController(rootVC: CartVC(viewModel: cartVM), image: Images.basketIcon)
        let favoritesVM             = FavoritesVM(favoriteHandler: FavoriteStore())
        let favoritesVC             = configureNavigationController(rootVC: FavoritesVC(viewModel: favoritesVM), image: Images.starIcon)
        let profileVC               = configureNavigationController(rootVC: ProfileVC(), image: Images.personIcon)
        
        viewControllers             = [homeVC, cartVC, favoritesVC, profileVC]
    }

    
    private func configureNavigationController(rootVC: UIViewController, image: UIImage?) -> UINavigationController {
        let navigation              = UINavigationController(rootViewController: rootVC)
        navigation.tabBarItem.image = image
        return navigation
    }
}
