//
//  NotificationsCellData.swift
//  SoundBar
//
//  Created by Justin Cose on 8/11/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NotificationCellData: BaseCellNode {
    
    var notifInfoText = ASTextNode()
    var coverImage = ASImageNode()
    var profileImageNodes = [ASImageNode()]
    var likedComment = ASTextNode()
    var profileNodesBox = ASImageNode()
    var imageBox = ASImageNode()
    
    var followButton: ASImageNode?
    var followText: ASTextNode?
    
    var notificationsBox = ASImageNode()
    var notificationData: NotificationsModel!
    
    var cellType: String = "standard"
    
    init(notification: NotificationsModel) {
        super.init()
        
        notificationData = notification
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        var likedCommentHstack: ASLayoutElement!

        let centerText = ASCenterLayoutSpec(centeringOptions: .Y, child: notifInfoText)
        let overlayTextBox = ASOverlayLayoutSpec(child: notificationsBox, overlay: centerText)
        
        likedCommentHstack = ASStackLayoutSpec(direction: .horizontal,
                                                   spacing: 10,
                                                   justifyContent: .start,
                                                   alignItems: .center,
                                                   children: [profileImageNodes[0], overlayTextBox])
            
        var likedCommentStack: ASLayoutElement!
        
        if cellType == "following" {
            let followCenter = ASCenterLayoutSpec(centeringOptions: .XY, child: followText!)
            let followOverlay = ASOverlayLayoutSpec(child: followButton!, overlay: followCenter)
            
            let followEndInset = ASStackLayoutSpec(direction: .horizontal,
                                                       spacing: 0,
                                                       justifyContent: .end,
                                                       alignItems: .center,
                                                       children: [followOverlay])
            
            let followBoxInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width / 25), child: followEndInset)
            
            let followOverlayEnd = ASOverlayLayoutSpec(child: profileNodesBox, overlay: followBoxInset)

            likedCommentStack = ASOverlayLayoutSpec(child: followOverlayEnd, overlay: likedCommentHstack)


        }
        
        else {
            
            let coverEndInset = ASStackLayoutSpec(direction: .horizontal,
                                                       spacing: 0,
                                                       justifyContent: .end,
                                                       alignItems: .center,
                                                       children: [coverImage])
            
            let imageBoxInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width / 16.666), child: coverEndInset)
            
            
            let imageBoxOverlayEnd = ASOverlayLayoutSpec(child: imageBox, overlay: imageBoxInset)
            
            
            likedCommentStack = ASOverlayLayoutSpec(child: imageBoxOverlayEnd, overlay: likedCommentHstack)


        }

        return ASInsetLayoutSpec(insets: .init(top: 0, left: UIScreen.main.bounds.width / 25, bottom: 0, right: 0), child: likedCommentStack)
        
    }
    
    func setupNodes() {
        var userAction: String = "@\(notificationData.username) "
          if notificationData.type == .Repost {
            userAction.append("liked your repost")
            
            notifInfoText.attributedText = NSAttributedString(string: userAction, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            notifInfoText.maximumNumberOfLines = 2
            
            let textString = NSMutableAttributedString(string: userAction)
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: notificationData.username.count + 1))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().soundbarColorScheme(), range: NSRange(location: notificationData.username.count + 1, length: 6))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: notificationData.username.count + 7, length: 12))
            textString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0,length: userAction.count))
            
            notifInfoText.attributedText = textString
          }
          
          else if notificationData.type == .Released {
              userAction.append("released a new track")
            
            notifInfoText.attributedText = NSAttributedString(string: userAction, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            notifInfoText.maximumNumberOfLines = 2
            
            let textString = NSMutableAttributedString(string: userAction)
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: notificationData.username.count + 1))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().soundbarColorScheme(), range: NSRange(location: notificationData.username.count + 1, length: 9))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: notificationData.username.count + 10, length: 12))
            textString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0,length: userAction.count))
            
            notifInfoText.attributedText = textString
          }
          
          else if notificationData.type == .LikedComment {
            cellType = "LikedCommennt"
              userAction.append("liked your comment: \(notificationData.message)")
            
            notifInfoText.attributedText = NSAttributedString(string: userAction, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            notifInfoText.maximumNumberOfLines = 2
            
            let textString = NSMutableAttributedString(string: userAction)
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: notificationData.username.count + 1))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().soundbarColorScheme(), range: NSRange(location: notificationData.username.count + 1, length: 6))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: notificationData.username.count + 7, length: 15))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location: notificationData.username.count + 21, length: notificationData.message.count + 1))
            textString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0,length: userAction.count))

            notifInfoText.attributedText = textString
          }

          else if notificationData.type == .Following {
            notifInfoText.attributedText = NSAttributedString(string: userAction, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            notifInfoText.maximumNumberOfLines = 2
            
            cellType = "following"
            userAction.append("started following you")
            followText = ASTextNode()
            followButton = ASImageNode()
            followButton?.anchorPoint = CGPoint(x: 0.0, y: 0.5)
            followButton!.style.preferredSize = CGSize(width: 75, height: 25)
            followButton!.backgroundColor = UIColor().soundbarColorScheme()
            followButton!.cornerRadius = 5
            followButton!.addTarget(self, action: #selector(followClicked), forControlEvents: .touchUpInside)
            followText!.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            
            notifInfoText.attributedText = NSAttributedString(string: userAction, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            notifInfoText.maximumNumberOfLines = 2
            
            let textString = NSMutableAttributedString(string: userAction)
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: notificationData.username.count + 10))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().soundbarColorScheme(), range: NSRange(location: notificationData.username.count + 10, length: 9))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: notificationData.username.count + 19, length: 4))
            textString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0,length: userAction.count))

            notifInfoText.attributedText = textString
        }
        
        var currentImageSize: CGFloat = 50
        
        for (index, _) in profileImageNodes.enumerated() {
            profileImageNodes[index].image = UIImage(named: notificationData.profileImages[index])
            profileImageNodes[index].contentMode = .scaleAspectFill
            profileImageNodes[index].borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
            profileImageNodes[index].borderWidth = 0.5
            profileImageNodes[index].cornerRadius = currentImageSize / 2
            profileImageNodes[index].clipsToBounds = true
            profileImageNodes[index].style.preferredSize = .init(width: currentImageSize, height: currentImageSize)
            profileImageNodes[index].addTarget(self, action: #selector(didClickNotification), forControlEvents: .touchUpInside)
            currentImageSize -= 10
        }
        
        coverImage.image = UIImage(named: notificationData.songReference!)
        coverImage.style.preferredSize = CGSize(width: 60, height: 60)
        coverImage.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        coverImage.borderWidth = 0.5
        coverImage.addTarget(self, action: #selector(didClickNotification), forControlEvents: .touchUpInside)
        
        notificationsBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.923 , height: 30)
        profileNodesBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width , height: 50)
        imageBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    @objc func followClicked() {
        if followButton!.borderWidth == 0.5 {
            followText!.attributedText = NSAttributedString(string: "Follow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            
            followButton!.style.preferredSize = CGSize(width: 75, height: 25)
            followButton!.backgroundColor = UIColor().soundbarColorScheme()
            followButton!.borderWidth = 0
        }
        
        else {
            followText!.attributedText = NSAttributedString(string: "Unfollow", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
            
            followButton!.style.preferredSize = CGSize(width: 75, height: 25)
            followButton!.backgroundColor = UIColor.clear
            followButton!.borderWidth = 0.5
            followButton!.borderColor = UIColor.white.cgColor
        }
    }
    
    @objc func didClickNotification() {
        
    }
}
