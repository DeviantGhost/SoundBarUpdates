//
//  FollowCells.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var currentTabFollow = "Followers"

class FollowCells: BaseCellNode {
    
    let accountProfileImage = ASImageNode()
    let accountName = ASTextNode()
    let accountUsername = ASTextNode()

    var backgroundCell = ASImageNode()
    
    var followText = ASTextNode()
    var followBox = ASImageNode()
    
    var audioPlayer: AudioHandler!
    
    var followerNamesString = String()
    var followerUsernamesString = String()
    var followImageDataString = String()
    
    var randomFollowNumber = Int()
    
    var randomizeFollow = [1, 2, 3, 4]
    
    init(followerNames: String, followerUsernames: String, followImageData: String) {
        super.init()
        
        randomizeFollow.shuffle()
        randomFollowNumber = randomizeFollow[0]
        
        followerNamesString = followerNames
        followerUsernamesString = followerUsernames
        followImageDataString = followImageData
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 3,
                                          justifyContent: .center,
                                          alignItems: .baselineFirst,
                                          children: [accountName, accountUsername])
        
        let followCenterText = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: followText)
        let followButtonOverlay = ASOverlayLayoutSpec(child: followBox, overlay: followCenterText)
        
        let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textStack)
        
        let fullStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 5,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [accountProfileImage, textNodeInset, followButtonOverlay])
        
     
        
        let accountsListenStack = ASStackLayoutSpec(direction: .horizontal,
                                                   spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [fullStack])
        
        let centerOverlay = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: accountsListenStack)
        
        let fullStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: centerOverlay)
        
        let fullOverlay = ASOverlayLayoutSpec(child: backgroundCell, overlay: fullStackInset)
        
        return fullOverlay
    }
    
    private func setupNodes() {
        backgroundCell.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        backgroundCell.backgroundColor = UIColor.clear
        
        accountProfileImage.image = UIImage(named: followImageDataString)
        accountProfileImage.style.preferredSize = CGSize(width: 45, height: 45)
        accountProfileImage.cornerRadius = 45/2

        accountName.attributedText = NSAttributedString(string: followerNamesString, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        accountName.style.preferredSize = CGSize(width: 215, height: 20)//THIS NEEDS RE DONE

        accountUsername.attributedText = NSAttributedString(string: "@\(followerUsernamesString)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        accountUsername.style.preferredSize = CGSize(width: 215, height: 20)//THIS NEEDS RE DONE
        
        if randomFollowNumber == 1 && currentTabFollow == "Followers" {
            followText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.backgroundColor = UIColor().soundbarColorScheme()
            followBox.cornerRadius = 5
            followBox.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
        }
        
        else {
            followText.attributedText = NSAttributedString(string: "Unfollow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.borderWidth = 0.5
            followBox.borderColor = UIColor.white.cgColor
            followBox.cornerRadius = 5
            followBox.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
        }
    }
    
    @objc func followClicked() {
        if followBox.borderWidth == 0.5 {
            followText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.backgroundColor = UIColor().soundbarColorScheme()
            followBox.borderWidth = 0
        }
        else {
            followText.attributedText = NSAttributedString(string: "Unfollow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            followBox.style.preferredSize = CGSize(width: 75, height: 25)
            followBox.backgroundColor = UIColor.clear
            followBox.borderWidth = 0.5
            followBox.borderColor = UIColor.white.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
