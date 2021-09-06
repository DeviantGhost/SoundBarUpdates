//
//  ProfileInfo.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit


class SignUpWith: BaseCellNode {

    let spotifyBox = ASImageNode()
    let soundcloudBox = ASImageNode()
    let googleBox = ASImageNode()
    let tiktokBox = ASImageNode()
    let createBox = ASImageNode()
    
    
    let spotifyLogo = ASImageNode()
    let soundcloudLogo = ASImageNode()
    let googleLogo = ASImageNode()
    let tiktokLogo = ASImageNode()

    
    let spotifyText = ASTextNode()
    let soundcloundText = ASTextNode()
    let googleText = ASTextNode()
    let tiktokText = ASTextNode()
    let createText = ASTextNode()
    
    override init() {
        super.init()
        setupNodes()

        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let spotifyStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [spotifyLogo, spotifyText])
        
        let soundcloudStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [soundcloudLogo, soundcloundText])
        
        let googleStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [googleLogo, googleText])
        
        let tiktokStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [tiktokLogo, tiktokText])
        
        let spotifyInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: spotifyStack)
        let soundcloudInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: soundcloudStack)
        let googleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: googleStack)
        let tiktokInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: tiktokStack)
        
        let spotifyOverlay = ASOverlayLayoutSpec(child: spotifyBox, overlay: spotifyInset)
        let soundcloudOverlay = ASOverlayLayoutSpec(child: soundcloudBox, overlay: soundcloudInset)
        let googleOverlay = ASOverlayLayoutSpec(child: googleBox, overlay: googleInset)
        let tiktokOverlay = ASOverlayLayoutSpec(child: tiktokBox, overlay: tiktokInset)
        
        let centerSubmitLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: createText)
        let createOverlay = ASOverlayLayoutSpec(child: createBox, overlay: centerSubmitLayout)
        let createInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: createOverlay)

        let signUpLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [spotifyOverlay, soundcloudOverlay, googleOverlay, tiktokOverlay, createInset])
        
        return signUpLayout
    }
    
    func setupNodes() {
        
        spotifyText.attributedText = NSAttributedString(string: "Continue with Spotify", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        
        spotifyBox.backgroundColor = .clear
        spotifyBox.borderColor = UIColor.white.cgColor
        spotifyBox.borderWidth = 1
        spotifyBox.cornerRadius = 20
        spotifyBox.style.preferredSize = CGSize(width: 230, height: 40)
        spotifyBox.addTarget(self, action: #selector(spotifyClicked), forControlEvents: .touchUpInside)

        spotifyLogo.image = UIImage(named: "spotifyLogo")
        
        
        soundcloundText.attributedText = NSAttributedString(string: "Continue with Soundcloud", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        
        soundcloudBox.backgroundColor = .clear
        soundcloudBox.borderColor = UIColor.white.cgColor
        soundcloudBox.borderWidth = 1
        soundcloudBox.cornerRadius = 20
        soundcloudBox.style.preferredSize = CGSize(width: 230, height: 40)
        soundcloudBox.addTarget(self, action: #selector(soundcloudClicked), forControlEvents: .touchUpInside)

        soundcloudLogo.image = UIImage(named: "soundcloudLogo")

        
        googleText.attributedText = NSAttributedString(string: "Continue with Google", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        
        googleBox.backgroundColor = .clear
        googleBox.borderColor = UIColor.white.cgColor
        googleBox.borderWidth = 1
        googleBox.cornerRadius = 20
        googleBox.style.preferredSize = CGSize(width: 230, height: 40)
        googleBox.addTarget(self, action: #selector(googleClicked), forControlEvents: .touchUpInside)

        googleLogo.image = UIImage(named: "googleLogo")

        
        tiktokText.attributedText = NSAttributedString(string: "Continue with Tiktok", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        
        tiktokBox.backgroundColor = .clear
        tiktokBox.borderColor = UIColor.white.cgColor
        tiktokBox.borderWidth = 1
        tiktokBox.cornerRadius = 20
        tiktokBox.style.preferredSize = CGSize(width: 230, height: 40)
        tiktokBox.addTarget(self, action: #selector(tiktokClicked), forControlEvents: .touchUpInside)

        tiktokLogo.image = UIImage(named: "tiktokLogo")

        
        createText.attributedText = NSAttributedString(string: "Create an account", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        createBox.backgroundColor = UIColor().soundbarColorScheme()
        createBox.borderWidth = 1
        createBox.cornerRadius = 20
        createBox.style.preferredSize = CGSize(width: 230, height: 40)
        createBox.addTarget(self, action: #selector(createClicked), forControlEvents: .touchUpInside)
    }
    
    
    @objc func spotifyClicked() {
        
        self.closestViewController?.navigationController?.popViewController(animated: true)
      
    }
    
    @objc func soundcloudClicked() {
        
        self.closestViewController?.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func googleClicked() {
        
        self.closestViewController?.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tiktokClicked() {
        
        self.closestViewController?.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func createClicked() {
        
        NotificationCenter.default.post(name: NSNotification.Name("createAccountClicked"), object: nil)

    }
    
    
}

