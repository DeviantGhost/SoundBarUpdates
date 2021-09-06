//
//  SendButton.swift
//  SoundBar
//
//  Created by Justin Cose on 8/7/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SendButton: BaseCellNode {

    var sendBox = ASImageNode()
    var sendText = ASTextNode()
    
    override init() {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(messageSendable), name: NSNotification.Name("messageSendable"), object: nil)
        
        setupNodes()
 
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerSend = ASCenterLayoutSpec(centeringOptions: .XY, child: sendText)
        let sendOverlay = ASOverlayLayoutSpec(child: sendBox, overlay: centerSend)

        let fullStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [sendOverlay])
        

        return fullStack
    }

    func setupNodes() {
        sendBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 50)
        sendBox.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        sendBox.cornerRadius = 10
        sendBox.addTarget(self, action: #selector(sendClicked), forControlEvents: .touchUpInside)
        
        sendText.attributedText = NSAttributedString(string: "Send", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
    }

    @objc func messageSendable() {
        sendBox.backgroundColor = UIColor().soundbarColorScheme()
    }

    @objc func sendClicked() {
        self.closestViewController?.dismiss(animated: true, completion: nil)

        successType = "Sent"
        NotificationCenter.default.post(name: Notification.Name("success"), object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }

}

