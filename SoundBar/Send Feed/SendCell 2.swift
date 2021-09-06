//
//  SendCell.swift
//  SoundBar
//
//  Created by Justin Cose on 8/7/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SendCell: BaseCellNode {
    
    let artistProfileImage = ASImageNode()
    let artistName = ASTextNode()
    let artistUsername = ASTextNode()
    
    var backgroundCell = ASImageNode()
    
    var arrowIcon = ASImageNode()
    
    var moreIcon = ASImageNode()
    var moreCircle = ASImageNode()
  
    var followText = ASTextNode()
    var followBox = ASImageNode()
    
    var audioPlayer: AudioHandler!
    
    var followerNamesString = String()
    var followerUsernamesString = String()
    var followImageDataString = String()
    
    init(followerNames: String, followerUsernames: String, followImageData: String) {
        super.init()
        
        followerNamesString = followerNames
        followerUsernamesString = followerUsernames
        followImageDataString = followImageData
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var fullStack = ASStackLayoutSpec()
                
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 3,
                                          justifyContent: .center,
                                          alignItems: .baselineFirst,
                                          children: [artistName, artistUsername])
        
        let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textStack)
        
        if newMessage == false {
            fullStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 5,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [artistProfileImage, textNodeInset, followBox])
        }
        
        else {
            fullStack = ASStackLayoutSpec(direction: .horizontal,
                                        spacing: 5,
                                        justifyContent: .start,
                                        alignItems: .center,
                                        children: [artistProfileImage, textNodeInset, arrowIcon])
        }
        
        let artistsListenStack = ASStackLayoutSpec(direction: .horizontal,
                                                   spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [fullStack])
        
        let centerOverlay = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: artistsListenStack)
        
        let fullStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: centerOverlay)
        
        let fullOverlay = ASOverlayLayoutSpec(child: backgroundCell, overlay: fullStackInset)
        
        return fullOverlay
    }
    
    private func setupNodes() {
        arrowIcon.image = UIImage(named: "SettingsArrow")
        arrowIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        backgroundCell.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        backgroundCell.backgroundColor = UIColor.clear
        
        artistProfileImage.image = UIImage(named: followImageDataString)
        artistProfileImage.style.preferredSize = CGSize(width: 45, height: 45)
        artistProfileImage.cornerRadius = 45/2
        artistProfileImage.addTarget(self, action: #selector(newMessageClicked), forControlEvents: .touchUpInside)

        artistName.attributedText = NSAttributedString(string: followerNamesString, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        artistName.addTarget(self, action: #selector(newMessageClicked), forControlEvents: .touchUpInside)
        artistName.style.preferredSize = CGSize(width: 260, height: 20)//THIS NEEDS RE DONE

        artistUsername.attributedText = NSAttributedString(string: "@\(followerUsernamesString)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        artistUsername.addTarget(self, action: #selector(newMessageClicked), forControlEvents: .touchUpInside)
        artistUsername.style.preferredSize = CGSize(width: 260, height: 20)//THIS NEEDS RE DONE
        
        followBox.style.preferredSize = CGSize(width: 25, height: 25)
        followBox.cornerRadius = 25/2
        followBox.borderWidth = 0.5
        followBox.borderColor = UIColor.white.cgColor
        followBox.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
        
        moreIcon.image = UIImage(named: "MoreIconCircles")
        moreIcon.style.preferredSize = .init(width: 20, height: 20)
        moreIcon.contentMode = .scaleAspectFill
    
        moreCircle.style.preferredSize = .init(width: 30, height: 30)
        moreCircle.cornerRadius = 30/2
        moreCircle.backgroundColor = UIColor(red: 0.125, green: 0.125, blue: 0.125, alpha: 1)
        moreCircle.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
    }
    
    @objc func newMessageClicked() {
        messageUsername = followerUsernamesString
        messageImage = followImageDataString

        self.closestViewController?.navigationController?.pushViewController(MessageCellViewController(), animated: true)
    }
    
    @objc func followClicked() {
        NotificationCenter.default.post(name: Notification.Name("messageSendable"), object: nil)

        if followBox.borderWidth == 0.5 {
            followBox.style.preferredSize = CGSize(width: 25, height: 25)
            followBox.backgroundColor = UIColor().soundbarColorScheme()
            followBox.borderWidth = 0
        }
        else {
            followBox.style.preferredSize = CGSize(width: 25, height: 25)
            followBox.backgroundColor = UIColor.clear
            followBox.borderWidth = 0.5
            followBox.borderColor = UIColor.white.cgColor
        }
    }
    
    @objc func artistClicked() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}


