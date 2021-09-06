//
//  MessagesTop.swift
//  SoundBar
//
//  Created by Justin Cose on 7/25/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var newMessage = false

class MessagesTop: BaseCellNode {
    
    var newMessageCircle = ASImageNode()
    var newMessageIcon = ASImageNode()
    
    var backCircle = ASImageNode()
    var backArrowIcon = ASImageNode()
    
    var titleText = ASTextNode()
    
    var topBuffer = ASImageNode()
    
    var audioPlayer = AudioHandler()
    
    override init() {
        super.init()

        self.backgroundColor = UIColor().topBackgroundGray()
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let newMessageOverlay = ASOverlayLayoutSpec(child: newMessageCircle, overlay: newMessageIcon)
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backArrowIcon)
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: UIScreen.main.bounds.width / 5,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay, titleText, newMessageOverlay])
        
        let fullDisplayBuffer = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [topBuffer, fullDisplay])
        
        return fullDisplayBuffer
        
    }
    
    private func setupNodes() {
        newMessageIcon.image = UIImage(named: "AddPlaylistIcon")
        newMessageIcon.style.preferredSize = CGSize(width: 30, height: 30)

        newMessageCircle.style.preferredSize = CGSize(width: 30, height: 30)
        newMessageCircle.cornerRadius = 30/2
        newMessageCircle.backgroundColor = UIColor().buttonsGray()
        newMessageCircle.addTarget(self, action: #selector(newMessageClicked), forControlEvents: .touchUpInside)
        
        backArrowIcon.image = UIImage(named: "FollowBackButton")
        backArrowIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor().buttonsGray()
        backCircle.addTarget(self, action: #selector(backFollowClicked), forControlEvents: .touchUpInside)

        topBuffer.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 25)
    
        titleText.attributedText = NSAttributedString(string: "Direct Messages", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    @objc func newMessageClicked() {
        newMessage = true
        self.closestViewController?.navigationController?.pushViewController(NewMessageViewController(), animated: true)
    }
    
    @objc func backFollowClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
//    @objc func profileButtonClicked() {
//        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)
//    }
}

