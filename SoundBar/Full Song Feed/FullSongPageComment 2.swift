//
//  FullSongPageComment.swift
//  SoundBar
//
//  Created by Justin Cose on 8/8/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FullSongPageComment: BaseCellNode, ASEditableTextNodeDelegate {

    var messageText = ASEditableTextNode()
    
    var background = ASImageNode()
    var sendButton = ASImageNode()
    var sendIcon = ASImageNode()
    
    var profilePicture = ASImageNode()
    var libraryBackground = ASImageNode()

    var audioPlayer = AudioHandler()
    var animationHandler: HomeAnimationHandler!
    
    override init() {
        super.init()
        
        animationHandler = HomeAnimationHandler()
   
        setUpNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let messageCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: messageText)
   
        let fullOverlay = ASOverlayLayoutSpec(child: background, overlay: messageCenter)
        let fullDisplayInset = ASInsetLayoutSpec(insets: .init(top: 15, left: 0, bottom: 15, right: 0), child: fullOverlay)
        return fullDisplayInset
    }
    
    override func didEnterVisibleState() {
        self.view.addSubnode(self.messageText)
    }
    
    func setUpNodes() {
        messageText.delegate = self
        messageText.attributedPlaceholderText = .init(string: "Type a comment...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        messageText.backgroundColor = .clear
        messageText.style.preferredSize = .init(width: 270, height: 50)
        messageText.textContainerInset = .init(top: 7, left: 10, bottom: 0, right: 0)
        messageText.enablesReturnKeyAutomatically = true
        messageText.tintColor = UIColor().soundbarColorScheme()
        messageText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        messageText.alpha = 0.75
        
        background.style.preferredSize = CGSize(width: 340, height: 34)
        background.cornerRadius = 5
        background.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.75)

        sendButton.style.preferredSize = CGSize(width: 34, height: 34)
        sendButton.cornerRadius = 5
        sendButton.backgroundColor = UIColor().soundbarColorScheme()
    
        sendIcon.style.preferredSize = CGSize(width: 34, height: 34)
        sendIcon.image = UIImage(named: "SendMessageIcon")
        sendIcon.zPosition = 25
        sendIcon.alpha = 0
        
        profilePicture.style.preferredSize = CGSize(width: 34, height: 34)
        profilePicture.image = UIImage(named: "commentsPfp1")
        profilePicture.cornerRadius = 34/2
        profilePicture.backgroundColor = UIColor().backgroundGray()
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
    
    @objc func stopTyping() {
        NotificationCenter.default.post(name: Notification.Name("stopTyping"), object: nil)
    }
}


