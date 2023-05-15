//
//  ViewController.swift
//  MovieDB Modular
//
//  Created by Finn Christoffer Kurniawan on 13/05/23.
//

import UIKit
import Home

class BaseViewController: UITabBarController {
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
  // MARK: - Helpers
  
  private func setupTabBar() {
    let homeImage = UIImage(systemName: "house.fill")
    let homeVC = HomeModule().container.resolve(HomeViewController.self)
    let home = templateNavigationController(image: homeImage, rootViewController: homeVC!, title: "Home")
    
//    let searchImage = UIImage(systemName: "magnifyingglass.circle")
//    let searchVC = Injection().container.resolve(SearchViewController.self)
//    let search = templateNavigationController(image: searchImage, rootViewController: searchVC!, title: "Search")
//
//    let favoriteImage = UIImage(systemName: "heart.fill")
//    let favoriteVC = Injection().container.resolve(FavoriteViewController.self)
//    let favorite = templateNavigationController(image: favoriteImage, rootViewController: favoriteVC!, title: "Favorite")
//
//    let accountImage = UIImage(systemName: "person.fill")
//    let account = templateNavigationController(image: accountImage, rootViewController: AccountViewController(), title: "Account")
    
//    viewControllers = [home, search, favorite, account]
    viewControllers = [home]
  }
  
  private func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String) -> UINavigationController {
    let nav = UINavigationController(rootViewController: rootViewController)
    nav.tabBarItem.image = image
    nav.tabBarItem.title = title
    nav.navigationBar.tintColor = UIColor.systemBlue
    
    tabBar.tintColor = UIColor.systemBlue
    tabBar.backgroundColor = .systemBackground
    tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
    tabBar.layer.shadowRadius = 2
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOpacity = 0.3
    return nav
  }
}

