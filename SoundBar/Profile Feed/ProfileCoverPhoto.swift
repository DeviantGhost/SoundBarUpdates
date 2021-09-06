//
//  ProfileCoverPhoto.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-21.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ProfileCoverPhoto: BaseNode {
    
    let backgroundImageNode = ASNetworkImageNode()
    let profileImageNode = ASNetworkImageNode()
    let shadeImageNode = ASImageNode()
    let nameNode = ASTextNode()
    let usernameNode = ASTextNode()
    let followersTextNode = ASTextNode()
    let followersCountNode = ASTextNode()
    let followingTextNode = ASTextNode()
    let followingCountNode = ASTextNode()
    let likesTextNode = ASTextNode()
    let likesCountNode = ASTextNode()

    var userInfo: ProfileHeader!
    
    init(userData: ProfileHeader?) {
        super.init()
        userInfo = userData
        setupNodes()
    }
    
    override func didLoad() {
        print("loaded cover photo")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let hStackProfile = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [profileImageNode])
        let profileInset = ASInsetLayoutSpec(insets: .zero, child: hStackProfile)
        let followersCount = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 5,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [followersCountNode, followersTextNode])
        let followingCount = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 5,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [followingCountNode, followingTextNode])
        let likesCount = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 5,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [likesCountNode, likesTextNode])
        let hStackCounts = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 25,
                                               justifyContent: .start,
                                               alignItems: .stretch,
                                               children: [followersCount, followingCount, likesCount])
        
        let center = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: hStackCounts)
        let stackInset = ASInsetLayoutSpec(insets: .init(top: 200, left: 0, bottom: 0, right: 0), child: center)
        
        let vStackCoverImageArea = ASStackLayoutSpec(direction: .vertical,
                                                     spacing: 10,
                                                     justifyContent: .center,
                                                     alignItems: .center,
                                                     children: [profileInset, usernameNode])
        
        let shadeOverlay = ASOverlayLayoutSpec(child: backgroundImageNode, overlay: shadeImageNode)
        let ov = ASOverlayLayoutSpec(child: shadeOverlay, overlay: vStackCoverImageArea)
        return ASOverlayLayoutSpec(child: ov, overlay: stackInset)
    }
    
    private func setupNodes() {
        shadeImageNode.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        shadeImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width - 6, height: 196)
        
        backgroundImageNode.url = URL(string: userInfo.coverLink!)
        backgroundImageNode.contentMode = .scaleAspectFill
        backgroundImageNode.style.preferredSize.width = UIScreen.main.bounds.width
        backgroundImageNode.style.preferredSize.height = 250
        
        profileImageNode.url = URL(string: userInfo.profileLink!)
        profileImageNode.contentMode = .scaleAspectFill
        profileImageNode.style.preferredSize = .init(width: 80, height: 80)
        profileImageNode.cornerRadius = 80/2
        profileImageNode.borderWidth = 2
        profileImageNode.borderColor = UIColor.white.cgColor
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let grayColorAttributes = [NSAttributedString.Key.foregroundColor: UIColor(white: 1, alpha: 0.85), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)]
        let largeAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        
        followersTextNode.attributedText = NSAttributedString(string: "FOLLOWERS", attributes: grayColorAttributes)
        followingTextNode.attributedText = NSAttributedString(string: "FOLLOWING", attributes: grayColorAttributes)
        likesTextNode.attributedText = NSAttributedString(string: "LIKES", attributes: grayColorAttributes)
        
        usernameNode.attributedText = NSAttributedString(string: userInfo.username! , attributes: largeAttributes)
        followersCountNode.attributedText = NSAttributedString(string: userInfo.followersCount!, attributes: attributes)
        followingCountNode.attributedText = NSAttributedString(string: userInfo.followingCount!, attributes: attributes)
        likesCountNode.attributedText = NSAttributedString(string: userInfo.likesCount!, attributes: attributes)
    }
    
}
