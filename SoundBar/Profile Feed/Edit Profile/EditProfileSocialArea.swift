//
//  EditProfileSocialArea.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-31.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class EditProfileSocialArea: BaseNode {
    
    let socialsText = ASTextNode()
    let social1 = ASImageNode()
    let social2 = ASImageNode()
    let social3 = ASImageNode()
    let social4 = ASImageNode()
    let social5 = ASImageNode()
    let social6 = ASImageNode()
    
    let socialText1 = ASTextNode()
    let socialText2 = ASTextNode()
    let socialText3 = ASTextNode()
    let socialText4 = ASTextNode()
    let socialText5 = ASTextNode()
    let socialText6 = ASTextNode()

    
    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let leftPadding = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .start,
                                            alignItems: .start,
                                            children: [socialsText])
        let vStackText = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 15,
                                           justifyContent: .center,
                                           alignItems: .stretch,
                                           children: [social1, social2, social3, social4, social5, social6])
        let vStackTextInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 25, bottom: 0, right: 0), child: vStackText)
        
        let vStackEditText = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 35,
                                               justifyContent: .center,
                                               alignItems: .stretch,
                                               children: [socialText1, socialText2, socialText3, socialText4, socialText5, socialText6])
        
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
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        socialsText.attributedText = NSAttributedString(string: "Socials", attributes: attributes)
        
        social1.backgroundColor = .red
        social1.style.preferredSize = .init(width: 40, height: 40)
        social1.cornerRadius = 40/2
        
        socialText1.attributedText = NSAttributedString(string: "@dababy", attributes: attributes)
        
        social2.backgroundColor = .blue
        social2.style.preferredSize = .init(width: 40, height: 40)
        social2.cornerRadius = 40/2
        
        socialText2.attributedText = NSAttributedString(string: "@dababy", attributes: attributes)
        
        social3.backgroundColor = .green
        social3.style.preferredSize = .init(width: 40, height: 40)
        social3.cornerRadius = 40/2
        
        socialText3.attributedText = NSAttributedString(string: "@officialdababybusiness", attributes: attributes)
        
        social4.backgroundColor = .yellow
        social4.style.preferredSize = .init(width: 40, height: 40)
        social4.cornerRadius = 40/2
        
        socialText4.attributedText = NSAttributedString(string: "@facebook.com/dababy", attributes: attributes)
        
        social5.backgroundColor = .white
        social5.style.preferredSize = .init(width: 40, height: 40)
        social5.cornerRadius = 40/2
        
        socialText5.attributedText = NSAttributedString(string: "dababy", attributes: attributes)
        
        social6.backgroundColor = .purple
        social6.style.preferredSize = .init(width: 40, height: 40)
        social6.cornerRadius = 40/2
        
        socialText6.attributedText = NSAttributedString(string: "dababyofficial", attributes: attributes)
    }
}
