//
//  ExploreDetails.swift
//  SoundBar
//
//  Created by Carlon Rosales on 8/31/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ExploreDetails: BaseCellNode {
    
    var libraryDetailText = ASTextNode()
    var background = ASImageNode()
    
    let soundbarCopyright = "© 2021 Soundbar, LLC"
    let backgroundDimentions = CGSize(width: UIScreen.main.bounds.width, height: 110)
    
    override init(){
        super.init()
        
        setUpNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let detailInset = ASInsetLayoutSpec(insets: .init(top: 20, left: 20, bottom: 0, right: 0), child: libraryDetailText)
        let libraryDetails = ASOverlayLayoutSpec(child: background, overlay: detailInset)
        return libraryDetails
    }
    
    func setUpNodes(){
        background.style.preferredSize = backgroundDimentions
        background.backgroundColor = UIColor().topBackgroundGray()
        
        libraryDetailText.attributedText = NSAttributedString(string: soundbarCopyright, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
    }
}


