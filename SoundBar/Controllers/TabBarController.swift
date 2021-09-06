//
//  TabBarController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//
//#FFD732

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
        NotificationCenter.default.addObserver(self, selector: #selector(animateIconClicked), name: NSNotification.Name(rawValue: "animateIcon"), object: nil)
    }
    
    @objc private func animateIconClicked() {
        
    }

    private func setupTapBar() {
        delegate = self
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = true
        configureControllers()
        
    }

    private func tabBarIcons() {
        
        //changed way tab controller is set up
        
        //search tab does not function correctly still
        
        //could not get main feed tab to animate, is a tab controller best method?
        
        
             let searchIcon = (self.tabBar.items?[0])! as UITabBarItem
             searchIcon.image = UIImage(named: "searchButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             searchIcon.selectedImage = UIImage(named: "searchButtonClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             searchIcon.title = ""
             searchIcon.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
     
             let profileIcon = (self.tabBar.items?[1])! as UITabBarItem
             profileIcon.image = UIImage(named: "homeButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             profileIcon.selectedImage = UIImage(named: "homeButtonClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             profileIcon.title = ""
             profileIcon.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            
        
             let listeningIcon = (self.tabBar.items?[2])! as UITabBarItem
             listeningIcon.image = UIImage(named: "profileButton")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             listeningIcon.selectedImage = UIImage(named: "profileButtonClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
             listeningIcon.title = ""
             listeningIcon.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        
        /*
        let searchIcon = UITabBarItem(title: "", image: UIImage(named: "exploreButton"), selectedImage: UIImage.init(named: "exploreButtonClicked"))
        

        
        searchController.tabBarItem = searchIcon
        
        
     
        
        let listeningIcon = UITabBarItem(title: "", image: UIImage(named: "homeNormal"), selectedImage: UIImage.init(named: "homeSelected"))
        
        
        listeningController.tabBarItem = listeningIcon
        
        let profileIcon = UITabBarItem(title: "", image: UIImage(named: "profileButton"), selectedImage: UIImage(named: "profileButtonClicked"))
        profileController.tabBarItem = profileIcon
 
 */
        
        
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
