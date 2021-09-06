//
//  ProfileInfo.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

var artistProfile = false

import AsyncDisplayKit

class ProfileInfo: BaseCellNode {
    
    var buffer = ASImageNode()
    var topBuffer = ASImageNode()
    
    var profilePicture = ASImageNode()
    var name = ASTextNode()
    var username = ASTextNode()
    
    var followerCount = ASTextNode()
    var followingCount = ASTextNode()
    
    let followerText = ASTextNode()
    let followingText = ASTextNode()
    
    let editProfileText = ASTextNode()
    let uploadText = ASTextNode()
    
    let editProfileButton = ASImageNode()
    let uploadTextButton = ASButtonNode()

    let bioNode = ASTextNode()
    
    let linkNode = ASTextNode()
<<<<<<< Updated upstream
    let firstSettingsBtn = ASButtonNode()
    let settingsBtnNode = ASButtonNode()
    let lastSettingsBtn = ASButtonNode()
    var userInfo: ProfileHeader!
    var isOtherArtist: Bool!

    init(userData: ProfileHeader?, isArt: (Bool, Bool)) {
        super.init()
        userInfo = userData
        isOtherArtist = isArt.0
=======

    var userInfo: ProfileHeader?

    init(userProfile: ProfileHeader) {
        super.init()
        
        userInfo = userProfile
        
        self.backgroundColor = .clear
>>>>>>> Stashed changes
        setupNodes()
    }
        
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let topStackOne = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [buffer])
        
        let topStackTwo = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 5,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [profilePicture, name, username])
        
        let topStackInset = ASStackLayoutSpec(direction: .vertical,
                                              spacing: -40,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [topStackOne, topStackTwo])
        
        let topStack = ASInsetLayoutSpec(insets: .init(top: globalTopScreenPadding + 10, left: 0, bottom: 0, right: 0), child: topStackInset)

        let followersStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 5,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [followerCount, followerText])
        
        let followingStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 5,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [followingCount, followingText])
        
        let followStack = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 35,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [followersStack, followingStack])
        
        let topTwoStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 20,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [topStack, followStack])
        
        let centerEditProfileText = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: editProfileText)
        
        let editProfileOverlay = ASOverlayLayoutSpec(child: editProfileButton, overlay: centerEditProfileText)
        
        let centerUploadText = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: uploadText)
        
        let uploadOverlay = ASOverlayLayoutSpec(child: uploadTextButton, overlay: centerUploadText)
        
        let buttonsStack = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 15,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [editProfileOverlay, uploadOverlay])
        
        let topThreeStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 20,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [topBuffer, topTwoStack, bioNode, buttonsStack])
        
        return topThreeStack
    }
    
<<<<<<< Updated upstream
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        self.closestViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
    }
//
    override func didExitVisibleState() {
        super.didExitVisibleState()
        self.closestViewController?.navigationController?.navigationBar.barTintColor = .black
        self.closestViewController?.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupNodes() {
        if isOtherArtist {
            firstSettingsBtn.setTitle("   Follow   ", with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
            lastSettingsBtn.setTitle("   Message   ", with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
            settingsBtnNode.setImage(.init(imageLiteralResourceName: "settingsIcon"), for: .normal)
//            settingsBtnNode.borderWidth = 1
            settingsBtnNode.borderColor = UIColor.white.cgColor
            firstSettingsBtn.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
            lastSettingsBtn.addTarget(self, action: #selector(messageClicked), forControlEvents: .touchUpInside)
            settingsBtnNode.addTarget(self, action: #selector(friendsClicked), forControlEvents: .touchUpInside)
        } else {
            firstSettingsBtn.setTitle("   Edit Profile   ", with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
            settingsBtnNode.setImage(.init(imageLiteralResourceName: "settingsIcon"), for: .normal)
            lastSettingsBtn.setTitle("   Upload   ", with: .boldSystemFont(ofSize: 16), with: .white, for: .normal)
            
            firstSettingsBtn.addTarget(self, action: #selector(editProfileClicked), forControlEvents: .touchUpInside)
            lastSettingsBtn.addTarget(self, action: #selector(messageButtonClicked), forControlEvents: .touchUpInside)
            settingsBtnNode.addTarget(self, action: #selector(settingsClicked), forControlEvents: .touchUpInside)
=======

    
    func setupNodes() {
        buffer.style.preferredSize = CGSize(width: 200, height: 15)
    
        if artistProfile == true {
            profilePicture.image = UIImage(named: userInfo?.profileLink ?? "")
            profilePicture.style.preferredSize = CGSize(width: 100, height: 100)
            profilePicture.cornerRadius = 100/2
            profilePicture.borderWidth = 1
            profilePicture.borderColor = UIColor.white.cgColor
        
            name.attributedText = NSAttributedString(string: userInfo?.fullName ?? "User", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            username.attributedText = NSAttributedString(string: userInfo?.username ?? "@username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            
            followerCount.attributedText = NSAttributedString(string: "\(userInfo?.followersCount ?? 100)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            followingCount.attributedText = NSAttributedString(string: "\(userInfo?.followingCount ?? 100)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            
            followerText.attributedText = NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            followingText.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            
            editProfileText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            uploadText.attributedText = NSAttributedString(string: "Message", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            
            followerCount.addTarget(self, action: #selector(followersClicked), forControlEvents: .touchUpInside)
            followingCount.addTarget(self, action: #selector(followingClicked), forControlEvents: .touchUpInside)
            followerText.addTarget(self, action: #selector(followersClicked), forControlEvents: .touchUpInside)
            followingText.addTarget(self, action: #selector(followingClicked), forControlEvents: .touchUpInside)

            editProfileButton.style.preferredSize = CGSize(width: 160, height: 40)
            editProfileButton.backgroundColor = UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1)
            editProfileButton.cornerRadius = 8
            editProfileButton.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
            
            uploadTextButton.style.preferredSize = CGSize(width: 160, height: 40)
            uploadTextButton.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
            uploadTextButton.cornerRadius = 8
            uploadTextButton.addTarget(self, action: #selector(messageButtonClicked), forControlEvents: .touchUpInside)
            
            bioNode.attributedText = NSAttributedString(string: userInfo?.bio ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])

>>>>>>> Stashed changes
        }

        else {
            profilePicture.image = UIImage(named: "commentsPfp1")
            profilePicture.style.preferredSize = CGSize(width: 100, height: 100)
            profilePicture.cornerRadius = 100/2
            profilePicture.borderWidth = 1
            profilePicture.borderColor = UIColor.white.cgColor
        
<<<<<<< Updated upstream
        firstSettingsBtn.borderWidth = 1
        firstSettingsBtn.borderColor = UIColor.white.cgColor
        firstSettingsBtn.cornerRadius = 5
        
        lastSettingsBtn.borderWidth = 1
        lastSettingsBtn.borderColor = UIColor.white.cgColor
        lastSettingsBtn.cornerRadius = 5
        
        bioNode.attributedText = NSAttributedString(string: userInfo.bio ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        linkNode.attributedText = NSAttributedString(string: userInfo.bioLink ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.link, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
    }
    
    @objc private func followClicked() {
        
=======
            name.attributedText = NSAttributedString(string: "Justin Cose", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
            username.attributedText = NSAttributedString(string: "\("@")justinrcose", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            
            followerCount.attributedText = NSAttributedString(string: "110", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            followingCount.attributedText = NSAttributedString(string: "83", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            
            followerText.attributedText = NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            followingText.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            
            editProfileText.attributedText = NSAttributedString(string: "Edit Profile", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            uploadText.attributedText = NSAttributedString(string: "Upload", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            
            followerCount.addTarget(self, action: #selector(followersClicked), forControlEvents: .touchUpInside)
            followingCount.addTarget(self, action: #selector(followingClicked), forControlEvents: .touchUpInside)
            followerText.addTarget(self, action: #selector(followersClicked), forControlEvents: .touchUpInside)
            followingText.addTarget(self, action: #selector(followingClicked), forControlEvents: .touchUpInside)
            
            editProfileButton.style.preferredSize = CGSize(width: 160, height: 40)
            editProfileButton.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
            editProfileButton.cornerRadius = 8
            editProfileButton.dropShadow()
            editProfileButton.addTarget(self, action: #selector(editProfileClicked), forControlEvents: .touchUpInside)
            
            uploadTextButton.style.preferredSize = CGSize(width: 160, height: 40)
            uploadTextButton.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
            uploadTextButton.cornerRadius = 8
            uploadTextButton.addTarget(self, action: #selector(uploadClicked), forControlEvents: .touchUpInside)
            
            bioNode.attributedText = NSAttributedString(string: "Follow the gram! Follow the TikTok!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        }
    }
    
    @objc func uploadClicked() {
        UIApplication.shared.openURL(NSURL(string: "https://04qahemhprh.typeform.com/to/ec2LwOQX")! as URL)
>>>>>>> Stashed changes
    }
    
    @objc func followersClicked() {
        currentTabFollow = "Followers"

        let vc = FollowController()
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func followingClicked() {
        currentTabFollow = "Following"
        
        let vc = FollowController()
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
<<<<<<< Updated upstream
    @objc private func editProfileClicked() {
        print("edit profile clicked")
        self.closestViewController?.navigationController?.pushViewController(EditProfileController(), animated: true)
=======
    @objc func editProfileClicked() {
        let vc = EditProfileController()
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
>>>>>>> Stashed changes
    }
    
    @objc func followClicked() {
        if editProfileButton.borderWidth == 0.5 {
            editProfileText.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            editProfileButton.style.preferredSize = CGSize(width: 160, height: 40)
            editProfileButton.backgroundColor = UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1)
            editProfileButton.borderWidth = 0
        }
        
        else {
            editProfileText.attributedText = NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
            editProfileButton.style.preferredSize = CGSize(width: 160, height: 40)
            editProfileButton.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
            editProfileButton.borderWidth = 0.5
            editProfileButton.borderColor = UIColor.white.cgColor
        }
    }
    
<<<<<<< Updated upstream
    @objc private func settingsClicked() {
        
=======
    @objc private func messageButtonClicked() {
        messageUsername = userInfo?.username ?? "@username"
        messageImage = userInfo?.profileLink ?? ""
        
        let vc = MessageCellViewController()
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
>>>>>>> Stashed changes
    }
}
