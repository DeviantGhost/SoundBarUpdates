//
//  MessageBottomControls.swift
//  SoundBar
//
//  Created by Justin Cose on 7/26/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class MessageBottomControls: BaseCellNode, ASEditableTextNodeDelegate {

    var messageText = ASEditableTextNode()
    
    var background = ASImageNode()
    
    var sendIcon = ASImageNode()
    var sendBackground = ASImageNode()

    var libraryIcon = ASImageNode()
    var libraryBackground = ASImageNode()

    var audioPlayer = AudioHandler()
    
    override init() {
        super.init()

        self.backgroundColor = UIColor().topBackgroundGray()
        
        setUpNodes()
 
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let messageCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: messageText)
        
        let libraryCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: libraryIcon)
        let libraryOverlay = ASOverlayLayoutSpec(child: libraryBackground, overlay: libraryCenter)

        let fullOverlay = ASOverlayLayoutSpec(child: background, overlay: messageCenter)
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [libraryOverlay, fullOverlay])
        
        let fullDisplayInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 30, right: 0), child: fullDisplay)
        
        return fullDisplayInset
        
    }
    
    override func didEnterVisibleState() {
        self.view.addSubnode(self.messageText)
    }
    
    func setUpNodes() {
        messageText.delegate = self
        messageText.attributedPlaceholderText = .init(string: "Type a message...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        messageText.backgroundColor = .clear
        messageText.style.preferredSize = .init(width: 270, height: 50)
        messageText.textContainerInset = .init(top: 7, left: 10, bottom: 0, right: 0)
        messageText.enablesReturnKeyAutomatically = true
        messageText.tintColor = UIColor().soundbarColorScheme()
        messageText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        messageText.alpha = 0.75
   
        background.style.preferredSize = CGSize(width: 300, height: 34)
        background.cornerRadius = 5
        background.backgroundColor = UIColor().buttonsGray()
        //background.addTarget(self, action: #selector(startTyping), forControlEvents: .touchUpInside)

        sendIcon.image = UIImage(named: "SendMessageIcon")
        sendIcon.style.preferredSize = CGSize(width: 34, height: 34)
        sendIcon.zPosition = 25
        sendIcon.alpha = 0
        
        sendBackground.style.preferredSize = CGSize(width: 34, height: 34)
        sendBackground.cornerRadius = 5
        sendBackground.backgroundColor = UIColor().soundbarColorScheme()
        
        libraryIcon.style.preferredSize = CGSize(width: 34, height: 34)
        libraryIcon.image = UIImage(named: "MessagesLibraryIcon")
        libraryIcon.zPosition = 20

        libraryBackground.backgroundColor = UIColor().buttonsGray()
        libraryBackground.style.preferredSize = CGSize(width: 34, height: 34)
        libraryBackground.cornerRadius = 5
        libraryBackground.addTarget(self, action: #selector(showMedia), forControlEvents: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    @objc func backFollowClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        NotificationCenter.default.post(name: Notification.Name("startTyping"), object: nil)
    }

    
    override func didExitVisibleState() {

    }
    
    
    @objc func stopTyping() {
        NotificationCenter.default.post(name: Notification.Name("stopTyping"), object: nil)
    }
    
    @objc func showMedia() {
        self.closestViewController?.present(MessageMediaViewController(), animated: true, completion: nil)
    }
    
//    @objc func profileButtonClicked() {
//        self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer), animated: true)
//    }

}


 
