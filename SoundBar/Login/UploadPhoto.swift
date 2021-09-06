//
//  ProfileInfo.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit


class UploadPhoto: BaseCellNode {
    
    let photoImg = ASImageNode()
    let backButton = ASImageNode()
    let fullNameBox = ASImageNode()
    let bioBox = ASImageNode()
    let submitBox = ASImageNode()
    
    let titleText = ASTextNode()
    let fullNameText = ASTextNode()
    let bioText = ASTextNode()
    let submitText = ASTextNode()
    let linkInstagramText = ASTextNode()
    let linkSoundCloudText = ASTextNode()
    let linkSpotifyText = ASTextNode()
    
    
    override init() {
        super.init()
        setupNodes()

        
    }
    
    override func didEnterVisibleState() {
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let nameInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: fullNameText)
        let bioInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 15, bottom: 0, right: 0), child: bioText)
    

        let centerTitleLayout = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: titleText)
        let photoImgLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: photoImg)
        let nameLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: nameInset)
        let centerSubmitLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: submitText)
        let instagramLinkLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: linkInstagramText)
        let soundcloudLinkLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: linkSoundCloudText)
        let spotifyLinkLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: linkSpotifyText)

        


        let nameOverlay = ASOverlayLayoutSpec(child: fullNameBox, overlay: nameLayout)
        let bioOverlay = ASOverlayLayoutSpec(child: bioBox, overlay: bioInset)
        let submitOverlay = ASOverlayLayoutSpec(child: submitBox, overlay: centerSubmitLayout)

        
        let backInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 10, bottom: 20, right: 0), child: backButton)
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 30, right: 0), child: centerTitleLayout)
        let submitInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: submitOverlay)
        
        
        let infoStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [photoImgLayout, titleInset, nameOverlay, bioOverlay, submitInset])
        
        let linkStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 15,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [instagramLinkLayout,soundcloudLinkLayout, spotifyLinkLayout])
        
        let linkInset = ASInsetLayoutSpec(insets: .init(top: 40, left: 0, bottom: 0, right: 0), child: linkStack)
        
        let backStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [backInset, infoStack, linkInset])
        
        return backStack
        
        
    }
    
    func setupNodes() {
        
        backButton.image = UIImage(named: "backNoCircle")
        photoImg.image = UIImage(named: "camera")


        backButton.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        
        titleText.attributedText = NSAttributedString(string: "Add a profile picture", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        
        fullNameText.attributedText = NSAttributedString(string: "Full name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        bioText.attributedText = NSAttributedString(string: "Bio Text", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        linkInstagramText.attributedText = NSAttributedString(string: "Link your Instagram", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])

        linkSoundCloudText.attributedText = NSAttributedString(string: "Link your Soundcloud", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])

        linkSpotifyText.attributedText = NSAttributedString(string: "Link your Spotify", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])

        
        fullNameBox.backgroundColor = .white
        fullNameBox.borderColor = UIColor.white.cgColor
        fullNameBox.borderWidth = 1
        fullNameBox.cornerRadius = 20
        fullNameBox.style.preferredSize = CGSize(width: 230, height: 40)
        
        bioBox.backgroundColor = .white
        bioBox.borderColor = UIColor.white.cgColor
        bioBox.borderWidth = 1
        bioBox.cornerRadius = 20
        bioBox.style.preferredSize = CGSize(width: 230, height: 120)

        
        submitText.attributedText = NSAttributedString(string: "Create account", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        submitBox.backgroundColor = UIColor().soundbarColorScheme()
        submitBox.borderWidth = 1
        submitBox.cornerRadius = 20
        submitBox.style.preferredSize = CGSize(width: 230, height: 40)
        submitBox.addTarget(self, action: #selector(signUpClicked), forControlEvents: .touchUpInside)
        
    }
    
    @objc func signUpClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)

    }
    
    @objc func backButtonClicked() {
        print("Back Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name("uploadPhotoBack"), object: nil)

    }
    
    
    
}


