//
//  MessageInfoDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 8/4/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MessageInfoDisplay: BaseCellNode {
    
    var infoTitleText = ASTextNode()
    
    var backIcon = ASImageNode()
    var backArrow = ASImageNode()
    var backArrowCounter = ASImageNode()
    
    var profileImageNode = ASImageNode()
    var username = ASTextNode()
    var usernameBox = ASImageNode()
    
    var muteMessagesText = ASTextNode()
    var muteMessageSwitch = UISwitch()
    
    var followText = ASTextNode()
    var followBox = ASImageNode()
    
    var reportText = ASTextNode()
    var blockText = ASTextNode()

    var cellSeperator = ASImageNode()
    var cellSeperatorTwo = ASImageNode()
    
    var audioPlayer: AudioHandler!
    
    
    override init() {
        super.init()
        
        audioPlayer = AudioHandler()

        self.backgroundColor = UIColor().backgroundGray()
        self.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        setupNodes()
    }
    

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let centerBack = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: backIcon)
        let backOverlay = ASOverlayLayoutSpec(child: backArrow, overlay: centerBack)
        
        let topStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 125,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay, infoTitleText, backArrowCounter])
        
        let centerUsername = ASCenterLayoutSpec(centeringOptions: .Y, child: username)
        let overlayUsername = ASOverlayLayoutSpec(child: usernameBox, overlay: centerUsername)
        
        let followCenterText = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: followText)
        let followButtonOverlay = ASOverlayLayoutSpec(child: followBox, overlay: followCenterText)
        
        let userStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .start,
                                            alignItems: .center,
                                            children: [profileImageNode, overlayUsername, followButtonOverlay])
        
        let userFullStack = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [cellSeperator, userStack, cellSeperatorTwo])
        
        let bottomStack = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 20,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [reportText, blockText])
        
        let fullStack = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 20,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [topStack, userFullStack, bottomStack])
        
        return fullStack
    
    }

    
    private func setupNodes() {
        
        backIcon.image = UIImage(named: "FollowBackButton")
        backIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        backArrow.style.preferredSize = CGSize(width: 30, height: 30)
        backArrow.cornerRadius = 30/2
        backArrow.backgroundColor = UIColor().buttonsGray()
        backArrow.addTarget(self, action: #selector(backClicked), forControlEvents: .touchUpInside)
        
        backArrowCounter.style.preferredSize = CGSize(width: 30, height: 30)
        backArrowCounter.cornerRadius = 30/2
        
        infoTitleText.attributedText = NSAttributedString(string: "Info", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        
        profileImageNode.image = UIImage(named: messageImage)
        profileImageNode.style.preferredSize = .init(width: 50, height: 50)
        profileImageNode.cornerRadius = 50/2
        profileImageNode.borderColor = UIColor.white.cgColor
        profileImageNode.borderWidth = 0.5
     //  profileImageNode.addTarget(self, action: #selector(profileClicked), forControlEvents: .touchUpInside)
        
        username.attributedText = NSAttributedString(string: messageUsername, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        usernameBox.style.preferredSize = CGSize(width: 220, height: 20)
        
        followText.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        followBox.style.preferredSize = CGSize(width: 75, height: 25)
        followBox.borderWidth = 0.5
        followBox.borderColor = UIColor.white.cgColor
        followBox.cornerRadius = 5
        followBox.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)

        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.3)
        cellSeperator.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        cellSeperatorTwo.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.3)
        cellSeperatorTwo.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        muteMessagesText.attributedText = NSAttributedString(string: "Mute Messages", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        
        muteMessageSwitch.isOn = false
        muteMessageSwitch.frame.size = CGSize(width: 100, height: 50)
        
        reportText.attributedText = NSAttributedString(string: "Report", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
  
        blockText.attributedText = NSAttributedString(string: "Block", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        blockText.addTarget(self, action: #selector(blockClicked), forControlEvents: .touchUpInside)
    }
    
    
    @objc func followClicked() {
        if followBox.borderWidth == 0.5 {
            followText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.backgroundColor = UIColor().soundbarColorScheme()
            followBox.borderWidth = 0
            
        }
        else {
            followText.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.backgroundColor = UIColor.clear
            followBox.borderWidth = 0.5
            followBox.borderColor = UIColor.white.cgColor
        }
    }
    
    @objc private func backClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveClicked() {
     
    }
    
    @objc private func blockClicked() {
        if blockText.backgroundColor == UIColor.red {
            blockText.attributedText = NSAttributedString(string: "Unblock", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        }
        
        else {
            blockText.attributedText = NSAttributedString(string: "Block", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)])
        }
    }
    
//    @objc private func profileClicked() {
//        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}

