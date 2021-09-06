//
//  MessageCellTop.swift
//  SoundBar
//
//  Created by Justin Cose on 3/21/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MessageCellTop: BaseCellNode {

    var profilePicture = ASImageNode()
    var usernameTextNode = ASTextNode()
    var usernameBackground = ASImageNode()
    
    var moreButtonCircle = ASImageNode()
    var moreButtonIcon = ASImageNode()
    
    var backCircle = ASImageNode()
    var backIcon = ASImageNode()
    
    var topBuffer = ASImageNode()

    var audioPlayer = AudioHandler()
    
    var data = hotBarsDataSourceStatic

    override init() {
        super.init()

        self.backgroundColor = UIColor().topBackgroundGray()
        
        setupNodes()
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let moreOverlay = ASOverlayLayoutSpec(child: moreButtonCircle, overlay: moreButtonIcon)
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backIcon)
        
        let usernameCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: usernameTextNode)
        let usernameOverlay = ASOverlayLayoutSpec(child: usernameBackground, overlay: usernameCenter)
        
        let nameImageStack = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [profilePicture, usernameOverlay])
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay, nameImageStack, moreOverlay])
        
        let fullDisplayBuffer = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [topBuffer, fullDisplay])
        
        return fullDisplayBuffer
        
    }
    
    private func setupNodes() {
        profilePicture.image = UIImage(named: messageImage)
        profilePicture.style.preferredSize = CGSize(width: 30, height: 30)
        profilePicture.cornerRadius = 30/2
        profilePicture.borderWidth = 0.5
        profilePicture.borderColor = UIColor.white.cgColor
    
        moreButtonIcon.image = UIImage(named: "MoreCirclesButton")
        moreButtonIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        moreButtonCircle.style.preferredSize = CGSize(width: 30, height: 30)
        moreButtonCircle.cornerRadius = 30/2
        moreButtonCircle.backgroundColor = UIColor().buttonsGray()
        moreButtonCircle.addTarget(self, action: #selector(infoClicked), forControlEvents: .touchUpInside)
 
        backIcon.image = UIImage(named: "FollowBackButton")
        backIcon.style.preferredSize = CGSize(width: 30, height: 30)

        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor().buttonsGray()
        backCircle.addTarget(self, action: #selector(backFollowClicked), forControlEvents: .touchUpInside)
  
        usernameTextNode.attributedText = NSAttributedString(string: messageUsername, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        usernameBackground.style.preferredSize = CGSize(width: 300, height: 20)
        
        topBuffer.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 35)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    @objc func infoClicked() {
        self.closestViewController?.navigationController?.pushViewController(MessageInfoViewController(), animated: true)
    }
    
    @objc func backFollowClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
//    @objc func profileButtonClicked() {
//        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)
//    }

}

