
//
//  SettingPageVC.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-03-22.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit


class SettingsPageViewController: ASDKViewController<BaseNode> {
    
    var settingsDisplay: SettingsDisplay!
    var background = ASImageNode()
    let activityDropDown = ASTextNode()
    let backButton = ASButtonNode()
    var audioPlayer: AudioHandler!
    
    var backCircle = ASImageNode()
   
    
    override init() {
        super.init(node: BaseNode())
        settingsDisplay = SettingsDisplay()
        settingsDisplay.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) //FIX
        settingsDisplay.zPosition = 4
        settingsDisplay.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        settingsDisplay.backgroundColor = .clear
        view.addSubnode(settingsDisplay)
        
        //self.node.backgroundColor = UIColor(red: 0.1, green: 1, blue: 0.1, alpha: 1)
                
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            
            let backOverlay = ASOverlayLayoutSpec(child: self.backCircle, overlay: self.backButton)
            
            let backInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 10, bottom: 0, right: 0), child: backOverlay)

            
            let activityInset = ASInsetLayoutSpec(insets: .init(top: 13, left: 0, bottom: 0, right: 0), child: self.activityDropDown)
            
            let topControls = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: (UIScreen.main.bounds.width / 2) - 90,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [backInset, activityInset])
            
            let topControlsInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 5, bottom: 0, right: 0), child: topControls)
            
            let controlsOverlay = ASOverlayLayoutSpec(child: self.background, overlay: topControlsInset)

            
            let vStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [controlsOverlay])
            
//            let controlsInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: vStack)
            

            return vStack
            
            
        }
        setupNodes()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNodes() {
        
        background.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        background.backgroundColor = UIColor().topBackgroundGray()
        
        backCircle.style.preferredSize = CGSize(width: 40, height: 40)
        backCircle.cornerRadius = 40/2
        backCircle.backgroundColor = UIColor().buttonsGray()
        backCircle.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        
        backButton.setImage(UIImage(named: "FollowBackButton"), for: .normal)
        backButton.style.preferredSize = CGSize(width: 50, height: 50)
        backButton.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        activityDropDown.attributedText = NSAttributedString(string: "Settings", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
