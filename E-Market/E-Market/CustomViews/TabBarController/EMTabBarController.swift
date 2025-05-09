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
        setupNotificationObservers()
        setCartBadge()
        delegate = self
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
    
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(setCartBadge), name: .changeCartDB, object: nil)
    }
    
    
    private func getCartCount(completion: @escaping (Int) -> Void) {
        let cartManager = CartStore()
        cartManager.fetchProductsFromLocalDB { result in
            switch result {
            case .success(let dbProducts):
                let distinctProducts = Set(dbProducts.map { $0.id ?? "" })
                completion(distinctProducts.count)
            case .failure(_):
                completion(0)
            }
        }
    }

    
    
    private func updateCartBadge(with count: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let cartTabBarItem = tabBar.items?[1]
            cartTabBarItem?.badgeValue = count > 0 ? "\(count)" : nil
        }
    }
    
    
    // MARK: - @Actions
    @objc private func setCartBadge() {
        getCartCount { [weak self] count in
            guard let self else { return }
            self.updateCartBadge(with: count)
        }
    }
}


// MARK: - UITabBarControllerDelegate
extension EMTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationController = viewController as? UINavigationController else { return }
        if navigationController.viewControllers.count > 1 {
            navigationController.popToRootViewController(animated: false)
        }
    }
}
