//
//  AccountTopControls.swift
//  SoundBar
//
//  Created by Justin Cose on 8/20/21.
//  Copyright © 2021 Soundbar 2021 All rights reserved.
//

import AsyncDisplayKit

class AccountTopControls: BaseNode {
    
    var backgroundFrame =  ASImageNode()

    var moreButtonCircle = ASImageNode()
    var moreButtonIcon = ASImageNode()
    
    var backCircle = ASImageNode()
    var settingsCircle = ASImageNode()
    
    var backIcon = ASImageNode()
    var settingsIcon = ASImageNode()
    
    var backButtonCircle = ASImageNode()
    var backButtonIcon = ASImageNode()

    var currentCell = [String: AnyObject]()

    override init() {
        super.init()
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backIcon)
        let moreOverlay = ASOverlayLayoutSpec(child: settingsCircle, overlay: settingsIcon)
        
        let leftCircles = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay])
        let rightCircles = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [moreOverlay])
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: UIScreen.main.bounds.width / 1.5,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [leftCircles, rightCircles])
    
        let display = ASOverlayLayoutSpec(child: backgroundFrame, overlay: fullDisplay)
        return display
    }
    
    private func setupNodes() {
        backIcon.image = UIImage(named: "FollowBackButton")
        backIcon.style.preferredSize = .init(width: 30, height: 30)
        backIcon.contentMode = .scaleAspectFill

        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        backCircle.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        
        if artistProfile == true {
            backIcon.alpha = 1
            backCircle.alpha = 1
        }
        else {
            backIcon.alpha = 0
            backCircle.alpha = 0
        }
        
        settingsIcon.image = UIImage(named: "MoreIconCircles")
        settingsIcon.style.preferredSize = .init(width: 30, height: 30)
        settingsIcon.contentMode = .scaleAspectFill
        
        settingsCircle.style.preferredSize = CGSize(width: 30, height: 30)
        settingsCircle.cornerRadius = 30/2
        settingsCircle.backgroundColor =  UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        settingsCircle.addTarget(self, action: #selector(sharePopUp), forControlEvents: .touchUpInside)
        
        moreButtonCircle.style.preferredSize = CGSize(width: 40, height: 40)
        moreButtonCircle.cornerRadius = 40/2
        moreButtonCircle.alpha = 0.7
        moreButtonCircle.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        moreButtonCircle.addTarget(self, action: #selector(sharePopUp), forControlEvents: .touchUpInside)

        backgroundFrame.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        backgroundFrame.backgroundColor = .clear
    }
    
    @objc func backButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("tabBarToggle"), object: nil)
        currentTab = "Playlists"
        artistProfile = false
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    @objc func sharePopUp() {
        if artistProfile == true {
            moreType = "ArtistPage"
            popUpHeight = (410 / UIScreen.main.bounds.height)
            popUpPosition = 1 - (410 / UIScreen.main.bounds.height)
            NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
        }
        else {
            let vc = SettingsPageViewController()
            vc.hidesBottomBarWhenPushed = true
           // self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

