//
//  SettingsDataNode.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SettingsDataNode: BaseCellNode {
    
    var textString = String()
    var imageString = String()
    
    let settingsIcon = ASImageNode()
    let settingsText = ASTextNode()
    let selectIcon = ASImageNode()
    let arrow = ASImageNode()
    
    init(Text: String!, Icons: String!) {
        super.init()

        textString = Text
        imageString = Icons
        print ("Data: \(textString)")

        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
//        let iconInset = ASInsetLayoutSpec(insets: .init(top: 2, left: 0, bottom: 0, right: 0), child: settingsIcon)
        let arrowInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 20, bottom: 0, right: 0), child: arrow)

        let textStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 25,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [settingsIcon, settingsText, arrowInset])
        
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: textStack)

        return collectionInset
    }
    
    private func setupNodes() {
        
        settingsIcon.image = UIImage(named: imageString)
        settingsIcon.forcedSize = CGSize(width: 15, height: 15)
        settingsText.attributedText = NSAttributedString(string: textString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        settingsText.style.preferredSize = CGSize(width: 250, height: 19)
        
        arrow.image = UIImage(named: "SettingsArrow")
        arrow.forcedSize = CGSize(width: 30, height: 30)
        
    }

}

