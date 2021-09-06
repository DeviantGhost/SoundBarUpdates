//
//  EditProfileCell.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class EditProfileCell: BaseCellNode {
    
    var dataNameString = String()
    var dataInfoString = String()
    
    let dataInfo = ASTextNode()
    let dataName = ASTextNode()
    
    var goButton = ASImageNode()
    var backgroundLayout = ASImageNode()
    
    init(Text: String!, Info: String!) {
        super.init()

        dataNameString = Text
        dataInfoString = Info

        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let infoStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 15,
                                          justifyContent: .end,
                                          alignItems: .center,
                                          children: [dataInfo, goButton])
        
        let infoOverlay = ASOverlayLayoutSpec(child: backgroundLayout, overlay: infoStack)
        
        let fullStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 80,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [dataName, infoOverlay])
        
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: fullStack)

        return collectionInset
    }
    
    private func setupNodes() {
        dataInfo.attributedText = NSAttributedString(string: dataInfoString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        dataName.attributedText = NSAttributedString(string: dataNameString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        dataName.style.preferredSize = .init(width: 80, height: 20)
        
        backgroundLayout.style.preferredSize = .init(width: 200, height: 30)
        backgroundLayout.addTarget(self, action: #selector(optionClicked), forControlEvents: .touchUpInside)
        backgroundLayout.backgroundColor = .clear
        
        goButton.image = UIImage(named: "GoButton")
        goButton.style.preferredSize = .init(width: 15, height: 30)
        goButton.contentMode = .scaleAspectFill
    }

    @objc private func optionClicked() {
        print(dataNameString)
        editProfilePageTitle = dataNameString
        editProfilePageInfo = dataInfoString
        self.closestViewController?.navigationController?.pushViewController(EditProfilePageViewController(), animated: true)
    }
}

