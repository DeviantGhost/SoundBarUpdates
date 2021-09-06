//
//  ProfileInfo.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit


class SignUpInfo: BaseCellNode, ASEditableTextNodeDelegate {
    
    let backButton = ASImageNode()
    let emailBox = ASImageNode()
    let usernameBox = ASImageNode()
    let passwordBox = ASImageNode()
    let rePasswordBox = ASImageNode()
    let submitBox = ASImageNode()
    
    let titleText = ASTextNode()
    let emailText = ASEditableTextNode()
    let usernameText = ASEditableTextNode()
    let passwordText = ASEditableTextNode()
    let rePasswordText = ASEditableTextNode()
    let submitText = ASTextNode()
    
    
    override init() {
        super.init()
        setupNodes()

        
    }
    
    override func didEnterVisibleState() {
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let emailInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: emailText)
        let usernameInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: usernameText)
        let passwordInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: passwordText)
        let rePasswordInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: rePasswordText)

        let centerTitleLayout = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: titleText)
        let emailLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: emailInset)
        let usernameLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: usernameInset)
        let passwordLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: passwordInset)
        let rePasswordLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: rePasswordInset)
        let centerSubmitLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: submitText)


        let emailOverlay = ASOverlayLayoutSpec(child: emailBox, overlay: emailLayout)
        let usernameOverlay = ASOverlayLayoutSpec(child: usernameBox, overlay: usernameLayout)
        let passwordOverlay = ASOverlayLayoutSpec(child: passwordBox, overlay: passwordLayout)
        let rePasswordOverlay = ASOverlayLayoutSpec(child: rePasswordBox, overlay: rePasswordLayout)
        let submitOverlay = ASOverlayLayoutSpec(child: submitBox, overlay: centerSubmitLayout)

        let backInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 10, bottom: 20, right: 0), child: backButton)
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 15, right: 0), child: centerTitleLayout)
        let submitInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: submitOverlay)
        
        
        let infoStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [titleInset, emailOverlay,usernameOverlay, passwordOverlay, rePasswordOverlay, submitInset])
        
        let backStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [backInset, infoStack])
        
        return backStack
        
    }
    
    func setupNodes() {
        
        backButton.image = UIImage(named: "backNoCircle")
        backButton.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        
        titleText.attributedText = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)])
        
        emailText.delegate = self
        emailText.attributedPlaceholderText = .init(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        emailText.backgroundColor = .clear
        emailText.style.preferredSize = .init(width: 230, height: 40)
        emailText.textContainerInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        emailText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor.rawValue: UIColor.gray]
        
        emailBox.backgroundColor = .white
        emailBox.borderColor = UIColor.white.cgColor
        emailBox.borderWidth = 1
        emailBox.cornerRadius = 20
        emailBox.style.preferredSize = CGSize(width: 230, height: 40)
        
        
        usernameText.delegate = self
        usernameText.attributedPlaceholderText = .init(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        usernameText.backgroundColor = .clear
        usernameText.style.preferredSize = .init(width: 230, height: 40)
        usernameText.textContainerInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        usernameText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor.rawValue: UIColor.gray]
        
        usernameBox.backgroundColor = .white
        usernameBox.borderColor = UIColor.white.cgColor
        usernameBox.borderWidth = 1
        usernameBox.cornerRadius = 20
        usernameBox.style.preferredSize = CGSize(width: 230, height: 40)
        
        passwordText.delegate = self
        passwordText.attributedPlaceholderText = .init(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        passwordText.backgroundColor = .clear
        passwordText.style.preferredSize = .init(width: 230, height: 40)
        passwordText.textContainerInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        passwordText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor.rawValue: UIColor.gray]
        
        passwordBox.backgroundColor = .white
        passwordBox.borderColor = UIColor.white.cgColor
        passwordBox.borderWidth = 1
        passwordBox.cornerRadius = 20
        passwordBox.style.preferredSize = CGSize(width: 230, height: 40)
        
        rePasswordText.delegate = self
        rePasswordText.attributedPlaceholderText = .init(string: "Re-Type", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        rePasswordText.backgroundColor = .clear
        rePasswordText.style.preferredSize = .init(width: 230, height: 40)
        rePasswordText.textContainerInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        rePasswordText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor.rawValue: UIColor.gray]
        
        rePasswordBox.backgroundColor = .white
        rePasswordBox.borderColor = UIColor.white.cgColor
        rePasswordBox.borderWidth = 1
        rePasswordBox.cornerRadius = 20
        rePasswordBox.style.preferredSize = CGSize(width: 230, height: 40)

        
        submitText.attributedText = NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        submitBox.backgroundColor = UIColor().soundbarColorScheme()
        submitBox.borderWidth = 1
        submitBox.cornerRadius = 20
        submitBox.style.preferredSize = CGSize(width: 230, height: 40)
        submitBox.addTarget(self, action: #selector(signUpClicked), forControlEvents: .touchUpInside)
        
    }
    
    
    @objc func signUpClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("signUp"), object: nil)

    }
    
    @objc func backButtonClicked() {
        print("Back Button Clicked")
        NotificationCenter.default.post(name: NSNotification.Name("signUpBack"), object: nil)

    }
    
    
    
}
