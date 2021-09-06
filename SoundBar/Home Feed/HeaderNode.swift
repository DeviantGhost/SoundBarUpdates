//
//  HeaderNode.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit


class HeaderNode: BaseNode {
    var currentPage = "HotBars"
    
    let topBar = ASImageNode()
    let whiteBoxOutline = ASImageNode()
    let selectedBox = ASImageNode()
    let followingNode = ASButtonNode()
    let barsNode = ASButtonNode()
 
    let backgroundSongImageName = ASImageNode()
    let backgroundSongImageArtist = ASImageNode()
<<<<<<< Updated upstream

    var followingClicked = true
    var hotBarsClicked = true
    var notificationsClicked = true
    
    override init() {
        super.init()
=======
    
    var topBarX = CGFloat()
    var topBarY = CGFloat()
    
    var followingClicked: Bool!
    var hotBarsClicked: Bool!
    var notificationsClicked: Bool! = true
    
    var audioPlayer: AudioHandler!
    
    init(following: Bool, hotBars: Bool, audio: AudioHandler) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clickedHotBarsButton), name: NSNotification.Name("swipeToHotbars"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clickedFollowingButton), name: NSNotification.Name("swipeToFollowing"), object: nil)
        
        audioPlayer = audio
        followingClicked = following
        hotBarsClicked = hotBars
        
>>>>>>> Stashed changes
        setupNode()
    }
    
    override func didEnterVisibleState() {
        whiteBoxOutline.borderColor = UIColor.white.cgColor
        whiteBoxOutline.borderWidth = 1
        whiteBoxOutline.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 125, y: followingNode.position.y - 20, width: 250, height: 40)
        whiteBoxOutline.cornerRadius = 12
        view.layer.addSubnode(whiteBoxOutline)
        
        selectedBox.frame = CGRect(x: barsNode.position.x - 62, y: barsNode.position.y - 17.5, width: 120, height: 35)
        selectedBox.backgroundColor = UIColor.black
        selectedBox.alpha = 0.75
        selectedBox.cornerRadius = 12
        view.layer.addSubnode(selectedBox)
        
        followingNode.zPosition = 100
        barsNode.zPosition = 100
        
        topBar.image = .init(imageLiteralResourceName: "TopBarTab")
        topBar.style.preferredSize = .init(width: 42, height: 4)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
<<<<<<< Updated upstream
        let notificationsSetup = ASCornerLayoutSpec(child: notificationsNode, corner: redNotificationsDot, location: .topRight)
        notificationsSetup.offset = CGPoint(x: -4, y: 3)
        let hStackNotifications = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 0,
                                                     justifyContent: .end,
                                                     alignItems: .end,
                                                     children: [notificationsSetup])

        let notificationsPadding = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 25), child: hStackNotifications)
        
        let hStackButtons = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 50,
                                       justifyContent: .end,
                                       alignItems: .stretch,
                                       children: [followingNode, barsNode, notificationsPadding])
//        let shareButtonPadding = ASInsetLayoutSpec(insets: .init(top: 10, left: 15, bottom: 10, right: 0), child: hStackButtons)
        return hStackButtons
    }
    
    private func setupNode() {
        followingButtonDidClick(); barsButtonDidClick(); notificationsButtonDidClick()
//        FirebaseHandler().handleAudioUpload()
=======
        let hStackButtonsBars = ASStackLayoutSpec(direction: .horizontal,
                                                  
                                                  spacing: 40,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [followingNode, barsNode])
        
        return hStackButtonsBars
    }
    
    private func setupNode() {
>>>>>>> Stashed changes
        backgroundSongImageName.backgroundColor = .black
        backgroundSongImageName.style.preferredSize = .init(width: 230, height: 45)
        backgroundSongImageArtist.backgroundColor = .black
        backgroundSongImageArtist.style.preferredSize = .init(width: 130, height: 30)
        
<<<<<<< Updated upstream
        redNotificationsDot.image = .init(imageLiteralResourceName: "notificationDot")
        redNotificationsDot.style.preferredSize = .init(width: 7.5, height: 7.5)
    }
  
    @objc func followingButtonDidClick() {
        followingClicked = !followingClicked
        if followingClicked {
            setupClickedFollowingButton()
            if hotBarsClicked {
                hotBarsClicked = !hotBarsClicked
                setupBarsButton()
            }
        } else {
            setupFollowingButton()
        }
    }
    
    @objc func barsButtonDidClick() {
        hotBarsClicked = !hotBarsClicked
        if hotBarsClicked {
            setupClickedBarsButton()
            if followingClicked {
                followingClicked = !followingClicked
                setupFollowingButton()
            }
        } else {
            setupBarsButton()
        }
    }
        
    @objc func notificationsButtonDidClick() {
        notificationsClicked = !notificationsClicked
        if notificationsClicked {
            print("notifications button clicked!")
        } else {
            notificationsNode.setImage(UIImage(named: "notificationBell"), for: .normal)
            notificationsNode.style.preferredSize = CGSize(width: 20, height: 27)
            notificationsNode.addTarget(self, action: #selector(notificationsButtonDidClick), forControlEvents: .touchUpInside)
        }
    }
    
    fileprivate func setupFollowingButton() {
        let followingAttributedString = NSMutableAttributedString(string: "Feed", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
=======
        barsNode.addTarget(self, action: #selector(clickedHotBarsButton), forControlEvents: .touchUpInside)
        followingNode.addTarget(self, action: #selector(clickedFollowingButton), forControlEvents: .touchUpInside)
        
        let barsAttributedString = NSMutableAttributedString(string: "Hot Bars", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        
        barsNode.setAttributedTitle(barsAttributedString, for: .normal)
        
        let followingAttributedString = NSMutableAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
>>>>>>> Stashed changes
        
        followingNode.setAttributedTitle(followingAttributedString, for: .normal)
        followingNode.addTarget(self, action: #selector(followingButtonDidClick), forControlEvents: .touchUpInside)
    }
    
<<<<<<< Updated upstream
    fileprivate func setupClickedFollowingButton() {
        let followingAttributedString = NSMutableAttributedString(string: "Feed", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.underlineColor: UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)])
        let rangeFol = Int(0.25 * Double(followingAttributedString.length))
        followingAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: rangeFol, length: followingAttributedString.length - 2 * rangeFol))
        followingNode.setAttributedTitle(followingAttributedString, for: .normal)
    }
    
    fileprivate func setupClickedBarsButton() {
        let barsAttributedString = NSMutableAttributedString(string: "Hot Bars", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.underlineColor: UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)])
        let rangeBars = Int(0.25 * Double(barsAttributedString.length))
        barsAttributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: rangeBars, length: barsAttributedString.length - 2 * rangeBars))
        barsNode.setAttributedTitle(barsAttributedString, for: .normal)
=======
    @objc func clickedFollowingButton() {
        if currentPage == "HotBars" {
            selectedBox.followingClicked()
            selectedBox.position.x -= 125
            
            let followingAttributedString = NSMutableAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            followingNode.setAttributedTitle(followingAttributedString, for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name("followingFeedClicked"), object: nil, userInfo: nil)
            
            let barsAttributedString = NSMutableAttributedString(string: "Hot Bars", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            barsNode.setAttributedTitle(barsAttributedString, for: .normal)
            
            currentPage = "Following"
        }
    }
    
    @objc func clickedHotBarsButton() {
        if currentPage == "Following" {
            selectedBox.barsClicked()
            selectedBox.position.x += 125
            
            audioPlayer.restart()
            audioPlayer.startClip()
            
            let barsAttributedString = NSMutableAttributedString(string: "Hot Bars", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            barsNode.setAttributedTitle(barsAttributedString, for: .normal)
            
            NotificationCenter.default.post(name: NSNotification.Name("hotBarsClicked"), object: nil, userInfo: nil)
            
            let followingAttributedString = NSMutableAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            followingNode.setAttributedTitle(followingAttributedString, for: .normal)
            
            currentPage = "HotBars"
        }
>>>>>>> Stashed changes
    }
    
    fileprivate func setupBarsButton() {
        let barsAttributedString = NSMutableAttributedString(string: "Hot Bars", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        barsNode.setAttributedTitle(barsAttributedString, for: .normal)
        barsNode.addTarget(self, action: #selector(barsButtonDidClick), forControlEvents: .touchUpInside)
    }
}
