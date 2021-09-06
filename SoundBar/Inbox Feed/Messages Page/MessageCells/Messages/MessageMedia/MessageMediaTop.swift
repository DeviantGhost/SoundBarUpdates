//
//  MessageMediaTop.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class MessageMediaTop: BaseCellNode {

    var titleText = ASTextNode()
    
    var topBuffer = ASImageNode()

    var downBackIcon = ASImageNode()
    var backCircle = ASImageNode()
    var extraCircle = ASImageNode()

    var audioPlayer = AudioHandler()
    
    var data = hotBarsDataSourceStatic
    var isArtist: Bool!
    
    override init() {
        super.init()

        setupNodes()
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let newPlaylistOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: downBackIcon)
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: UIScreen.main.bounds.width / 3.5,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [newPlaylistOverlay, titleText, extraCircle])
        
        return fullDisplay
        
    }
    
    private func setupNodes() {
        
        downBackIcon.image = UIImage(named: "DownArrowPopUp")
        downBackIcon.style.preferredSize = CGSize(width: 30, height: 30)
        
        backCircle.style.preferredSize = CGSize(width: 35, height: 35)
        backCircle.cornerRadius = 35/2
        backCircle.backgroundColor = UIColor().buttonsGray()
        backCircle.addTarget(self, action: #selector(backFollowClicked), forControlEvents: .touchUpInside)
  
        extraCircle.style.preferredSize = CGSize(width: 40, height: 40)
        extraCircle.cornerRadius = 40/2
        
        topBuffer.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 10)
        
        titleText.attributedText = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }

    @objc func backFollowClicked() {
        self.closestViewController?.dismiss(animated: true, completion: nil)
    }
    
}



