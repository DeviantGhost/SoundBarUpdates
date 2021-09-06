//
//  EditProfileAccountArea.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-31.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class EditProfileAccountArea: BaseNode {
    
    let accountText = ASTextNode()
    let nameText = ASTextNode()
    let usernameText = ASTextNode()
    let websiteText = ASTextNode()
    let bioText = ASTextNode()
    
    let nameEditText = ASEditableTextNode()
    let usernameEditText = ASEditableTextNode()
    let websiteEditText = ASEditableTextNode()
    let bioEditText = ASEditableTextNode()
    
    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leftPadding = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .start,
                                            alignItems: .start,
                                            children: [accountText])
        let vStackText = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 15,
                                           justifyContent: .start,
                                           alignItems: .stretch,
                                           children: [nameText, usernameText, websiteText, bioText])
        let vStackTextInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 25, bottom: 0, right: 0), child: vStackText)
        
        let vStackEditText = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 15,
                                               justifyContent: .start,
                                               alignItems: .stretch,
                                               children: [nameEditText, usernameEditText, websiteEditText, bioEditText])
        
        let hStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 50,
                                       justifyContent: .start,
                                       alignItems: .stretch,
                                       children: [vStackTextInset, vStackEditText])
    
        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 15,
                                       justifyContent: .start,
                                       alignItems: .stretch,
                                       children: [leftPadding, hStack])
        return vStack
    }
    
    private func setupNodes() {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        accountText.attributedText = NSAttributedString(string: "Account", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)])
        nameText.attributedText = NSAttributedString(string: "Name", attributes: attributes)
        usernameText.attributedText = NSAttributedString(string: "Username", attributes: attributes)
        websiteText.attributedText = NSAttributedString(string: "Website", attributes: attributes)
        bioText.attributedText = NSAttributedString(string: "Bio", attributes: attributes)
        
        nameEditText.attributedText = NSAttributedString(string: "DaBaby", attributes: attributes)
        usernameEditText.attributedText = NSAttributedString(string: "@dababyofficial", attributes: attributes)
        websiteEditText.attributedText = NSAttributedString(string: "www.youtube.com/watch?v", attributes: attributes)
        bioEditText.attributedText = NSAttributedString(string: "NEW MUSIC VIDEO CLICK\nTHE LINK", attributes: attributes)
        
    }
}
