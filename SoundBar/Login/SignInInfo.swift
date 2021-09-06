//
//  ProfileInfo.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit


class SignInInfo: BaseCellNode, ASEditableTextNodeDelegate {
    
    let emailBox = ASImageNode()
    let passwordBox = ASImageNode()
    let submitBox = ASImageNode()
    
    let emailText = ASEditableTextNode()
    let passwordText = ASEditableTextNode()
    let submitText = ASTextNode()
    
    
    override init() {
        super.init()
        setupNodes()

        
    }
    
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let emailInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: emailText)
        let passwordInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 15, bottom: 0, right: 0), child: passwordText)
        
        let centerSubmitLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: submitText)
        let emailLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: emailInset)
        let passwordLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: passwordInset)


        let emailOverlay = ASOverlayLayoutSpec(child: emailBox, overlay: emailLayout)
        let passwordOverlay = ASOverlayLayoutSpec(child: passwordBox, overlay: passwordLayout)
        
        let submitOverlay = ASOverlayLayoutSpec(child: submitBox, overlay: centerSubmitLayout)

        let submitInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: submitOverlay)

        let infoStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 10,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [emailOverlay, passwordOverlay, submitInset])
        
        return infoStack
        
    }
    
    func setupNodes() {
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

        
        submitText.attributedText = NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        
        submitBox.backgroundColor = UIColor().soundbarColorScheme()
        submitBox.borderWidth = 1
        submitBox.cornerRadius = 20
        submitBox.style.preferredSize = CGSize(width: 230, height: 40)
        
    }
    
    
    @objc func signInClicked() {
        self.closestViewController?.navigationController?.pushViewController(SettingsPageViewController(), animated: true)
    }
    
    
    
}
