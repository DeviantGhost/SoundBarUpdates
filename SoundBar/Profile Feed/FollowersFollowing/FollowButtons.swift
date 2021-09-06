//
//  FollowButtons.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var newXLocationFollowUnderline = CGFloat()

class FollowButtons: BaseCellNode {

    var followersText = ASTextNode()
    var followingText = ASTextNode()

    var followersBox = ASImageNode()
    var followingBox = ASImageNode()

    var underline = ASImageNode()
    
    override init() {
        super.init()

        self.backgroundColor = UIColor().topBackgroundGray()
        
        setupNodes()
    }

    override func didEnterVisibleState() {
        if currentTabFollow == "Followers" {
            underline.frame = CGRect(x: 0, y: 37, width: UIScreen.main.bounds.width / 2, height: 3)
            underline.backgroundColor = UIColor().soundbarColorScheme()
            view.addSubnode(underline)
        }
        if currentTabFollow == "Following" {
            underline.frame = CGRect(x: UIScreen.main.bounds.width / 2, y: 37, width: UIScreen.main.bounds.width / 2, height: 3)
            underline.backgroundColor = UIColor().soundbarColorScheme()
            view.addSubnode(underline)
        }
    }

    

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let followersTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: followersText)
        let followingTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: followingText)
        
        let playlistOverlay = ASOverlayLayoutSpec(child: followersBox, overlay: followersTextCenter)
        let artistOverlay = ASOverlayLayoutSpec(child: followingBox, overlay: followingTextCenter)
        
        let buttonsStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 0,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [playlistOverlay, artistOverlay])

        let centerButtonsStack = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: buttonsStack)

        return centerButtonsStack
    }

    private func setupNodes() {
        if currentTabFollow == "Followers" {
            followersText.attributedText = NSAttributedString(string: "110 Followers", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            followingText.attributedText = NSAttributedString(string: "83 Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        }
        
        if currentTabFollow == "Following" {
            followersText.attributedText = NSAttributedString(string: "110 Followers", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
            followingText.attributedText = NSAttributedString(string: "83 Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        }

        followersBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 20)
        
        followersText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        followersText.addTarget(self, action: #selector(followersClicked), forControlEvents: .touchUpInside)

        followingBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 20)
    
        followingText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        followingText.addTarget(self, action: #selector(followingClicked), forControlEvents: .touchUpInside)
    }

    @objc func followersClicked() {
        currentTabFollow = "Followers"
        
        NotificationCenter.default.post(name: Notification.Name("playlistClicked"), object: nil)

        newXLocationFollowUnderline = followersBox.position.x

        underline.moveBar()
        underline.position.x = newXLocationFollowUnderline

        followersText.attributedText = NSAttributedString(string: "110 Followers", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        followingText.attributedText = NSAttributedString(string: "83 Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }

    @objc func followingClicked() {
        currentTabFollow = "Following"

        NotificationCenter.default.post(name: Notification.Name("artistClicked"), object: nil)

        newXLocationFollowUnderline = followingBox.position.x
        
        underline.moveBar()
        underline.position.x = newXLocationFollowUnderline
        
        followersText.attributedText = NSAttributedString(string: "110 Followers", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        followingText.attributedText = NSAttributedString(string: "83 Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

extension ASImageNode {
    func moveBarFollow() {
        let initialPosition = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = newXLocationFollowUnderline
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
}
