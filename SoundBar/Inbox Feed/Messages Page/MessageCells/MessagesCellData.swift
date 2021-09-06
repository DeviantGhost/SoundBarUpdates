//
//  MessagesCellData.swift
//  SoundBar
//
//  Created by Justin Cose on 3/17/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var messageUsername = String()
var messageImage = String()

class MessagesCellData: BaseCellNode {
    
    var profileImage = String()
    var username = String()
    var message = String()
    var timeStamp = String()
    
    var profileImageNode = ASImageNode()
    var usernameNode = ASTextNode()
    var likedMessage = ASTextNode()
    var timeStampNode = ASTextNode()
    
    var messageBackground = ASImageNode()
 
    let newMessageDot = ASImageNode()
    var randomArray = [1,2, 3]
    var randomNumber = Int()
    
    init(ProfileImage: String, Username: String, Comment: String, TimeStamp: String) {
        super.init()
        
        randomArray.shuffle()
        randomNumber = randomArray[0]
        
        profileImage = ProfileImage
        username = Username
        message = Comment
        timeStamp = TimeStamp
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let likedMessageTextStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [usernameNode, likedMessage])
        let likedMessageHstack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 8,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [profileImageNode, likedMessageTextStack])
        
        let leftStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 20,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [newMessageDot, timeStampNode])
        
        let likedMessageStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 15,
                                          justifyContent: .start,
                                          alignItems: .center,
                                          children: [likedMessageHstack, leftStack])
        let likedMessageStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: likedMessageStack)
        
        let fullOverlay = ASOverlayLayoutSpec(child: messageBackground, overlay: likedMessageStackInset)
        return fullOverlay
    }
    
    private func setupNodes() {
        messageBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 75)
        messageBackground.backgroundColor = UIColor().backgroundGray()
        messageBackground.addTarget(self, action: #selector(goToMessage), forControlEvents: .touchUpInside)
        
        profileImageNode.image = UIImage(named: profileImage)
        profileImageNode.contentMode = .scaleAspectFill
        profileImageNode.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        profileImageNode.borderWidth = 0.5
        profileImageNode.cornerRadius = 60/2
        profileImageNode.clipsToBounds = true
        profileImageNode.style.preferredSize = .init(width: 60, height: 60)

        usernameNode.attributedText = NSAttributedString(string: "@\(username)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        usernameNode.style.preferredSize = CGSize(width: 220, height: 15)
        
        timeStampNode.attributedText = NSAttributedString(string: timeStamp, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
    
        if randomNumber == 1{
            newMessageDot.backgroundColor = UIColor().soundbarColorScheme()
            newMessageDot.style.preferredSize = CGSize(width: 8, height: 8)
            newMessageDot.cornerRadius = 8/2
            
            likedMessage.attributedText = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            likedMessage.style.preferredSize = CGSize(width: 220, height: 15)
        }
        
        else {
            newMessageDot.backgroundColor = UIColor().soundbarColorScheme()
            newMessageDot.style.preferredSize = CGSize(width: 8, height: 8)
            newMessageDot.cornerRadius = 8/2
            newMessageDot.alpha = 0
            
            likedMessage.attributedText = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            likedMessage.style.preferredSize = CGSize(width: 220, height: 15)
        }
    }
    
    @objc func goToMessage() {
        messageUsername = username
        messageImage = profileImage

        self.closestViewController?.navigationController?.pushViewController(MessageCellViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
