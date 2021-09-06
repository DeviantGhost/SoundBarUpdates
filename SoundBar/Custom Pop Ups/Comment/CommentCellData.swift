//
//  File.swift
//  SoundBar
//
//  Created by Justin Cose on 9/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CommentCellData: BaseCellNode {
    
    var profileImage = String()
    var username = String()
    var comment = String()
    var likeCount = String()
    var timeStamp = String()
    var numberOfReplys = String()
    
    var usernameNode = ASTextNode()
    var commentNode = ASTextNode()
    var likeCountNode = ASTextNode()
    var timeStampNode = ASTextNode()
    var numberOfReplysNode = ASTextNode()
    
    var profileImageNode = ASImageNode()
    var likeButton = ASButtonNode()
    var replyButton = ASTextNode()
    
    init(ProfileImage: String, Username: String, Comment: String, LikeCount: String, TimeStamp: String, NumberOfReplys: String) {
        super.init()
        
        profileImage = ProfileImage
        username = Username
        comment = Comment
        
        likeCount = LikeCount
        timeStamp = TimeStamp
        
        numberOfReplys = NumberOfReplys
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let usernameCommentStack = ASStackLayoutSpec(direction: .vertical,
                                                     spacing: 3,
                                                     justifyContent: .center,
                                                     alignItems: .baselineFirst,
                                                     children: [usernameNode, commentNode])
        
        let timeLikesReplyStack = ASStackLayoutSpec(direction: .horizontal,
                                                    spacing: 15,
                                                    justifyContent: .start,
                                                    alignItems: .baselineFirst,
                                                    children: [timeStampNode, likeCountNode, replyButton])
        
        let allVstack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 3,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [usernameCommentStack, timeLikesReplyStack])
        
        let Hstack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 8,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [profileImageNode, allVstack])
        
        let allHstack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 30,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [Hstack, likeButton])
        
        let allHstackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: allHstack)
        
        return allHstackInset
    }
    
    private func setupNodes() {
        profileImageNode.image = UIImage(named: profileImage)
        profileImageNode.contentMode = .scaleAspectFill
        profileImageNode.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        profileImageNode.borderWidth = 0.5
        profileImageNode.cornerRadius = 25/2
        profileImageNode.clipsToBounds = true
        profileImageNode.style.preferredSize = .init(width: 25, height: 25)
        
        likeButton.setImage(UIImage(named: "LikeCommentButton"), for: .normal)
        likeButton.setImage(UIImage(named: "LikeCommentButtonClicked"), for: .selected)
        likeButton.zPosition = 3
        likeButton.frame.size = CGSize(width: 12, height: 12)
        likeButton.style.preferredSize = CGSize(width: 12, height: 12)
        likeButton.addTarget(self, action: #selector(likeButtonClicked), forControlEvents: .touchUpInside)
        
        replyButton.attributedText = NSAttributedString(string: "Reply", attributes: [NSAttributedString.Key.foregroundColor : UIColor().soundbarColorScheme(), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        replyButton.addTarget(self, action: #selector(replyClicked), forControlEvents: .touchUpInside)
        
        usernameNode.attributedText = NSAttributedString(string: "@\(username)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        
        commentNode.attributedText = NSAttributedString(string: comment, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        commentNode.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 120, height: 22)
        
        likeCountNode.attributedText = NSAttributedString(string: "\(likeCount) likes", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        timeStampNode.attributedText = NSAttributedString(string: timeStamp, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        
        numberOfReplysNode.attributedText = NSAttributedString(string: numberOfReplys, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
    }
    
    @objc func replyClicked() {
        replyUsername = username
        NotificationCenter.default.post(name: Notification.Name("replyComment"), object: nil)
    }
    
    @objc private func likeButtonClicked() {
        if likeButton.isSelected {
            likeButton.isSelected = false
        }
        else {
            likeButton.isSelected = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
