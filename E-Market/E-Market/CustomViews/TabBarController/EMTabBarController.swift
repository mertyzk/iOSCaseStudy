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
        getCartCount()
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
    
    @discardableResult
    private func getCartCount() -> Int?{
        let cartManager = CartStore()
        var products: [Product] = []
        var distinctProducts: Set<String> = []
        cartManager.fetchProductsFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let dbProducts):
                products.append(contentsOf: dbProducts)
                distinctProducts = Set(products.map { $0.id ?? "" })
                self.updateCartBadge(with: distinctProducts.count)
            case .failure(_):
                break
            }
        }
        return distinctProducts.count
    }
    
    
    private func updateCartBadge(with count: Int) {
        let cartTabBarItem = tabBar.items?[1]
        cartTabBarItem?.badgeValue = count > 0 ? "\(count)" : nil
    }
    
    
    // MARK: - @Actions
    @objc private func setCartBadge() {
        guard let cartCount = getCartCount() else { return }
        updateCartBadge(with: cartCount)
    }
}
