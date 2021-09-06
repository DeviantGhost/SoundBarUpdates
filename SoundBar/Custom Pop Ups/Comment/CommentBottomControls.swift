//
//  CommentBottomControls.swift
//  SoundBar
//
//  Created by Justin Cose on 8/7/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var replyUsername = ""

class CommentBottomControls: BaseCellNode, ASEditableTextNodeDelegate {
    
    var username = ASTextNode()
    var keyboardHeight: CGFloat!

    var libraryText = ASTextNode()
    
    var topBuffer = ASImageNode()

    var messageText = ASEditableTextNode()
    
    var background = ASImageNode()
    
    var sendButton = ASImageNode()
    var sendIcon = ASImageNode()
    
    var profilePicture = ASImageNode()
    
    var extraCircle = ASImageNode()

    var audioPlayer = AudioHandler()
    
    var data = hotBarsDataSourceStatic
    var isArtist: Bool!
    
    override init() {
        super.init()
 
        NotificationCenter.default.addObserver(self, selector: #selector(replyComment), name: NSNotification.Name("replyComment"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startTypingComment), name: NSNotification.Name("startTypingComment"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startReplyingComment), name: NSNotification.Name("startReplyingComment"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        self.backgroundColor = UIColor().topBackgroundGray()
        setUpNodes()
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let messageCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: messageText)
        
        let fullOverlay = ASOverlayLayoutSpec(child: background, overlay: messageCenter)
        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [profilePicture, fullOverlay])
        
        let fullDisplayInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 30, right: 0), child: fullDisplay)
        
        return fullDisplayInset
    }
    
    override func didEnterVisibleState() {
        self.view.addSubnode(self.messageText)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard show notification two")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    @objc func startTypingComment() {

    }
    
    @objc func startReplyingComment() {
       
    }
    
    @objc func stopTyping() {
        self.barPopsUp(keyboard: keyboardHeight)
        NotificationCenter.default.post(name: Notification.Name("stopTyping"), object: nil)
    }
    
    func setUpNodes() {
        messageText.delegate = self
        messageText.attributedPlaceholderText = .init(string: "Add a comment...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        messageText.backgroundColor = .clear
        messageText.style.preferredSize = .init(width: 270, height: 50)
        messageText.textContainerInset = .init(top: 7, left: 10, bottom: 0, right: 0)
        messageText.enablesReturnKeyAutomatically = true
        messageText.tintColor = UIColor().soundbarColorScheme()
        messageText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        messageText.alpha = 0.75

        background.style.preferredSize = CGSize(width: 300, height: 34)
        background.cornerRadius = 5
        background.backgroundColor = UIColor().cellBackgroundGray()

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
    
    @objc func replyComment() {
        messageText.attributedText = NSAttributedString(string: "@\(replyUsername) ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])

        DispatchQueue.main.async { [self] in
            self.messageText.becomeFirstResponder()
        }
    }
    
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        self.barPopsUp(keyboard: self.keyboardHeight)
    }

    override func didExitVisibleState() {
        self.messageText.resignFirstResponder()
    }
}

