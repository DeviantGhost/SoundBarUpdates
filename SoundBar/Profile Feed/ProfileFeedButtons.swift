//
//  ProfileFeedButtons.swift
//  SoundBar
//
//  Created by Justin Cose on 7/8/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var newXLocationFeed = CGFloat()

class ProfileFeedButtons: BaseCellNode {

    var moveBarToTabPoint = CGFloat()
    
    var repostText = ASTextNode()
    var trackText = ASTextNode()
    
    var repostBox = ASImageNode()
    var trackBox = ASImageNode()

    var underline = ASImageNode()

    var isArtist: Bool!

    override init() {
        super.init()

        self.backgroundColor = UIColor.clear
        setupNodes()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let repostsTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: repostText)
        let trackTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: trackText)

        let trackOverlay = ASOverlayLayoutSpec(child: trackBox, overlay: trackTextCenter)
        let repostsOverlay = ASOverlayLayoutSpec(child: repostBox, overlay: repostsTextCenter)
        
        let repostsInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: repostsOverlay)
        let tracksInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: trackOverlay)
        
        var repostsBoxStack = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .end,
                                               alignItems: .center,
                                               children: [repostsInset, underline])

        var buttonsStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 0,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [repostsBoxStack, tracksInset])
        
        if artistProfile != true {
            repostsBoxStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .end,
                                                   alignItems: .center,
                                                   children: [repostsInset, underline])
            
            buttonsStack = ASStackLayoutSpec(direction: .horizontal,
                                                   spacing: 0,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [repostsBoxStack, tracksInset])
        }

        let centerButtonsStack = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: buttonsStack)
        return centerButtonsStack
    }

    private func setupNodes() {
        if artistProfile == true {
            repostBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 40)
            
            repostText.attributedText = NSAttributedString(string: "Reposts", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            repostText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            repostText.addTarget(self, action: #selector(repostsClicked), forControlEvents: .touchUpInside)

            trackBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 40)
        
            trackText.attributedText = NSAttributedString(string: "Tracks", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            trackText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            trackText.addTarget(self, action: #selector(tracksClicked), forControlEvents: .touchUpInside)
        }
        
        else {
            repostBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 40)
            
            repostText.attributedText = NSAttributedString(string: "Reposts", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            repostText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            repostText.addTarget(self, action: #selector(repostsClicked), forControlEvents: .touchUpInside)

            trackBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 40)
        
            trackText.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            trackText.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            trackText.addTarget(self, action: #selector(tracksClicked), forControlEvents: .touchUpInside)
        }

        underline.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 3)
        underline.backgroundColor = UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1)
    }

    @objc func repostsClicked() {
        NotificationCenter.default.post(name: Notification.Name("repostsClicked"), object: nil)

        newXLocationFeed = repostBox.position.x

        underline.moveBarProfile()
        underline.position.x = newXLocationFeed

        repostText.attributedText = NSAttributedString(string: "Reposts", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        trackText.attributedText = NSAttributedString(string: "Tracks", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }
    
    @objc func tracksClicked() {
        NotificationCenter.default.post(name: Notification.Name("tracksClicked"), object: nil)

        newXLocationFeed = trackBox.position.x

        underline.moveBarProfile()
        underline.position.x = newXLocationFeed
        
        repostText.attributedText = NSAttributedString(string: "Reposts", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        trackText.attributedText = NSAttributedString(string: "Tracks", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

extension ASImageNode {
    func moveBarProfile() {
        let initialPosition = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = newXLocationFeed
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
}
