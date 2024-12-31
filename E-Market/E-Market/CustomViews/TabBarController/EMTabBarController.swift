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
        let homeViewModel           = HomeViewModel(favoriteManager: FavoriteStore(), cartManager: CartStore())
        let homeViewController      = configureNavigationController(rootVC: HomeViewController(viewModel: homeViewModel), image: Images.homeIcon)
        let cartViewModel           = CartViewModel(cartManager: CartStore())
        let cartViewController      = configureNavigationController(rootVC: CartViewController(viewModel: cartViewModel), image: Images.basketIcon)
        let favoritesViewModel      = FavoritesViewModel(favoriteHandler: FavoriteStore())
        let favoritesViewController = configureNavigationController(rootVC: FavoritesViewController(viewModel: favoritesViewModel), image: Images.starIcon)
        let profileViewController   = configureNavigationController(rootVC: ProfileViewController(), image: Images.personIcon)

        viewControllers             = [homeViewController, cartViewController, favoritesViewController, profileViewController]
    }

    
    private func configureNavigationController(rootVC: UIViewController, image: UIImage?) -> UINavigationController {
        let navigation              = UINavigationController(rootViewController: rootVC)
        navigation.tabBarItem.image = image
        return navigation
    }
}
