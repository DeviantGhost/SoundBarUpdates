//
//  TabBarController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//
//

import AsyncDisplayKit

var tabBarHeight: CGFloat!
var globalTabBar : ASTabBarController!
var globalTopScreenPadding = CGFloat(0.0)

let window = UIApplication.shared.windows[0]
let globalScreenTopPadding = window.safeAreaInsets.top

extension Double {
    func unitRatio() -> (Double) {
        let unit = 1.0 / 844.0
        let ratioDecimal = Double(unit * Double(self))
        let ratioMeasure = Double(ratioDecimal * Double(UIScreen.main.bounds.height))
        return ratioMeasure
    }
}

extension Int {
    func unitRatio() -> (Int) {
        let unit = 1.0 / 844.0
        let ratioDecimal = Double(unit * Double(self))
        let ratioMeasure = Int(CGFloat(ratioDecimal * Double(UIScreen.main.bounds.height)))
        return ratioMeasure
    }
}

extension CGFloat {
    func unitRatio() -> (CGFloat) {
        let unit = 1.0 / 844.0
        let ratioDecimal = Double(unit * Double(self))
        let ratioMeasure = CGFloat(CGFloat(ratioDecimal * Double(UIScreen.main.bounds.height)))
        return ratioMeasure
    }
}

class TabBarController: ASTabBarController, UITabBarControllerDelegate {

    var audioPlayer = AudioHandler()
    var userInfo = ProfileHeader()
    
    var listeningController: HomeViewController!
    var searchController: ExploreController!
    var libraryController: LibraryController!
    var notificationsController: NotifcationsViewController!
    var profileController: AccountProfileController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.clipsToBounds = true
        tabBarHeight = CGFloat(90.0.unitRatio())
   
        listeningController = HomeViewController(space: Double(CGFloat(tabBarHeight)), audio: audioPlayer)
        searchController = ExploreController(audio: audioPlayer)
        libraryController = LibraryController(audio: audioPlayer)
        notificationsController = NotifcationsViewController()
        profileController = AccountProfileController(audio: audioPlayer, data: userInfo)
    
        self.tabBar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - tabBarHeight , width: UIScreen.main.bounds.width, height: tabBarHeight)
        self.view.frame = CGRect(x: 0, y: 0 , width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        setupTapBar()
        

        NotificationCenter.default.addObserver(self, selector: #selector(configureControllers), name: NSNotification.Name("returningUser"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        self.tabBar.clipsToBounds = true

        self.tabBar.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - tabBarHeight, width: UIScreen.main.bounds.width, height: tabBarHeight)
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    private func setupTapBar() {
        delegate = self
        tabBar.barTintColor = .black
        tabBar.barTintColor = UIColor().topBackgroundGray()
        tabBar.isTranslucent = false
        globalTabBar = self
   
        configureControllers()
    }
    
    private func tabBarIcons() {
        //changed way tab controller is set up
        
        let listeningIcon = (self.tabBar.items?[0])! as UITabBarItem
        listeningIcon.image = UIImage(named: "PlayButtonTabIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        listeningIcon.selectedImage = UIImage(named: "PlayButtonTabIconClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        listeningIcon.title = ""
    
        let searchIcon = (self.tabBar.items?[1])! as UITabBarItem
        searchIcon.image = UIImage(named: "SearchButtonTabIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        searchIcon.selectedImage = UIImage(named: "SearchButtonTabIconClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        searchIcon.title = ""
        
        let notificationsIcon = (self.tabBar.items?[2])! as UITabBarItem
        notificationsIcon.image = UIImage(named: "InboxButtonTabIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        notificationsIcon.selectedImage = UIImage(named: "InboxButtonTabIconClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        notificationsIcon.title = ""
        
        let libraryIcon = (self.tabBar.items?[3])! as UITabBarItem
        libraryIcon.image = UIImage(named: "LibraryButtonTabIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        libraryIcon.selectedImage = UIImage(named: "LibraryButtonTabIconClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        libraryIcon.title = ""

        let profileIcon = (self.tabBar.items?[4])! as UITabBarItem
        profileIcon.image = UIImage(named: "ProfileButtonTabIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        profileIcon.selectedImage = UIImage(named: "ProfileButtonTabIconClicked")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        profileIcon.title = ""
         
        listeningController.tabBarItem = listeningIcon
        searchController.tabBarItem = searchIcon
        libraryController.tabBarItem = libraryIcon
        notificationsController.tabBarItem = notificationsIcon
        profileController.tabBarItem = profileIcon
    }
    
    @objc private func configureControllers() {
        let listeningNavController = ASNavigationController(rootViewController: listeningController)
        listeningNavController.navigationBar.isTranslucent = true
        listeningNavController.setNavigationBarHidden(true, animated: true)
        listeningNavController.navigationBar.barTintColor = .black
        
        let searchNavController = ASNavigationController(rootViewController: searchController)
        searchNavController.navigationBar.isTranslucent = true
        searchNavController.navigationBar.barTintColor = .black
        searchNavController.setNavigationBarHidden(true, animated: true)
        
        let libraryNavController = ASNavigationController(rootViewController: libraryController)
        libraryNavController.navigationBar.isTranslucent = true
        libraryNavController.setNavigationBarHidden(true, animated: true)
        libraryNavController.navigationBar.barTintColor = .black
        
        let notificationsNavController = ASNavigationController(rootViewController: notificationsController)
        notificationsNavController.navigationBar.isTranslucent = true
        notificationsNavController.setNavigationBarHidden(true, animated: true)
        notificationsNavController.navigationBar.barTintColor = .black

        let profileNavController = ASNavigationController(rootViewController: profileController)
        profileNavController.navigationBar.isTranslucent = true
        profileNavController.setNavigationBarHidden(true, animated: true)
        profileNavController.navigationBar.barTintColor = .black
        
        let returningUser: Bool? = UserDefaults.standard.object(forKey: "returningUser") as? Bool

        if returningUser ?? false {
            viewControllers = [listeningNavController, searchNavController, notificationsNavController, libraryNavController, profileNavController]
            tabBarIcons()
            
            popUpHeight = (330 / UIScreen.main.bounds.height)
            popUpPosition = 1 - (330 / UIScreen.main.bounds.height)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                NotificationCenter.default.post(name: Notification.Name("loadWelcomePopUp"), object: nil)
            })
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}

 
