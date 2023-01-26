//
//  HomeTabsCoordinator.swift
//  Recipes
//
//  Created by Akash Desai on 2023-01-23.
//

import Foundation
import UIKit

class HomeTabsCoordinator: UIViewController {
    
    var homeTabBarController: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        view.backgroundColor = .white
    }
}

// MARK: Setup
private extension HomeTabsCoordinator {
    func setupTabs() {
        homeTabBarController = UITabBarController()
        homeTabBarController.tabBar.tintColor = .black
        addChild(homeTabBarController)
        homeTabBarController.didMove(toParent: self)
        homeTabBarController.view.embed(in: view)
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        homeTabBarController.tabBar.standardAppearance = tabBarAppearance
        homeTabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        let tabControllers = [
            makeHomeCoordinator(),
            makeUploadRecipeCoordinator(),
            makeShoppingListCoordinator(),
            makeFavouriteRecipesCoordinator(),
            makeMoreCoordinator()
        ]
        
        homeTabBarController.setViewControllers(tabControllers.compactMap { $0 }, animated: false)
    }
    
    func makeHomeCoordinator() -> UIViewController {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.homeUnselected.image, selectedImage: Asset.Assets.homeSelected.image)
        return homeCoordinator
    }
    
    func makeUploadRecipeCoordinator() -> UIViewController {
        let uploadRecipeCoordinator = UploadRecipeCoordinator()
        uploadRecipeCoordinator.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.uploadUnselected.image, selectedImage: Asset.Assets.uploadSelected.image)
        return uploadRecipeCoordinator
    }
    
    func makeShoppingListCoordinator() -> UIViewController {
        let shoppingListCoordinator = ShoppingListCoordinator()
        shoppingListCoordinator.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.shoppingUnselected.image, selectedImage: Asset.Assets.shoppingSelected.image)
        return shoppingListCoordinator
    }
    
    func makeFavouriteRecipesCoordinator() -> UIViewController {
        let favouriteRecipesCoordinator = FavouriteRecipesCoordinator()
        favouriteRecipesCoordinator.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.favouriteUnselected.image, selectedImage: Asset.Assets.favouriteSelected.image)
        return favouriteRecipesCoordinator
    }
    
    func makeMoreCoordinator() -> UIViewController {
        let profileCoordinator = MoreCoordinator()
        profileCoordinator.tabBarItem = UITabBarItem(title: nil, image: Asset.Assets.moreUnselected.image, selectedImage: Asset.Assets.moreSelected.image)
        return profileCoordinator
    }
}

