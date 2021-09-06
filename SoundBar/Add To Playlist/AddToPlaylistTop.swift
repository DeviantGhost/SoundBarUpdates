//
//  AddToPlaylistTop.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AddToPlaylistTop: BaseCellNode {
    
    var counterCircle = ASImageNode()
    var newMessageIcon = ASImageNode()
    
    var backCircle = ASImageNode()
    var backArrowIcon = ASImageNode()
    
    var titleText = ASTextNode()
    
    var audioPlayer = AudioHandler()
    
    override init() {
        super.init()

        self.backgroundColor = UIColor().topBackgroundGray()
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backArrowIcon)
        
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: UIScreen.main.bounds.width / 4,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay, titleText, counterCircle])
        
        return fullDisplay
    }
    
    private func setupNodes() {
        counterCircle.style.preferredSize = CGSize(width: 30, height: 30)
        counterCircle.cornerRadius = 30/2
        
        backArrowIcon.image = UIImage(named: "DownArrowPopUp")
        backArrowIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor().buttonsGray()
        backCircle.addTarget(self, action: #selector(backClicked), forControlEvents: .touchUpInside)
    
        titleText.attributedText = NSAttributedString(string: "Your Playlist's", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    @objc func backClicked() {
        self.closestViewController?.dismiss(animated: true, completion: nil)
    }
}

