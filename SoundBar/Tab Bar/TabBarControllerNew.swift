//
//  TabBarController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
/*

import AsyncDisplayKit

class TabBarController: ASTabBarController, UITabBarControllerDelegate {

    let searchController = ExploreController()
    var listeningController = ViewController(space: 49)
    let profileController = ProfileController()

    override func viewDidLoad() {
        super.viewDidLoad()
        if view.frame.height > 800 {
            listeningController = ViewController(space: 79)
        }
        setupTapBar()
        tabBarIcons()
    }

    private func setupTapBar() {
        delegate = self
       
        tabBar.barTintColor = UIColor.black
        
        configureControllers()
    }
    
    private func tabBarIcons() {
        
        let searchIcon = UITabBarItem(title: "", image: UIImage(named: "exploreButton"), selectedImage: UIImage.init(named: "exploreButtonClicked"))
      
        searchController.tabBarItem = searchIcon
        
     
        
        let listeningIcon = UITabBarItem(title: "", image: UIImage(named: "homeNormal"), selectedImage: UIImage.init(named: "homeSelected"))
        listeningController.tabBarItem = listeningIcon
        
        let profileIcon = UITabBarItem(title: "", image: UIImage(named: "profileButton"), selectedImage: UIImage(named: "profileButtonClicked"))
        profileController.tabBarItem = profileIcon
    }
    
    private func configureControllers() {
        let searchNavController = ASNavigationController(rootViewController: searchController)
    
        searchNavController.navigationBar.isTranslucent = true
        searchNavController.navigationBar.barTintColor = .black
        searchNavController.setNavigationBarHidden(true, animated: true)
        
        let listeningNavController = ASNavigationController(rootViewController: listeningController)
        listeningNavController.navigationBar.isTranslucent = true
        listeningNavController.setNavigationBarHidden(true, animated: true)
        listeningNavController.navigationBar.barTintColor = .black

        let profileNavController = ASNavigationController(rootViewController: profileController)
        profileNavController.navigationBar.isTranslucent = true
        profileNavController.setNavigationBarHidden(true, animated: true)
        profileNavController.navigationBar.barTintColor = .black

        viewControllers = [searchNavController, listeningNavController, profileNavController]
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
*/
