//
//  CommentPopUp.swift
//  SoundBar
//
//  Created by Justin Cose on 2/19/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.


import AsyncDisplayKit
import AVFoundation
import UIKit

class CommentPopUp: BaseNode, ASCollectionDelegate, ASCollectionDataSource, UICollectionViewDelegateFlowLayout, ASEditableTextNodeDelegate {
    
    var commentSectionNumberOfReplysData = ["0", "", "3", "1", "8", "62", "", "32", "", "64", "", "", "64", "", "86", "", "2", "", "235", "", "754", "", "", "", "536", "", "14", "", "", "6", "", "44", "", "532", "", "3", "", "", "4", "", "5", "32", "", "", "7", "", "3", "", "", ""]
    
    var CommentsSectionNode: ASCollectionNode!
    var AddCommentNode: ASCollectionNode!
    
    var commentsTitle = ASTextNode()
    
    var textHere = ASTextNode()
    
    var separatorLineTop = ASImageNode()
    var separatorLineBottom = ASImageNode()
    
    var addHeaderBox = ASImageNode()
    var addHeaderText = ASTextNode()
    
    var addCommentBox = ASImageNode()
    var addCommentText = ASTextNode()
    
    var commentBackground = ASImageNode()
    var commentBox = ASImageNode()
    var comment = ASEditableTextNode()
    
    var musicButton = ASImageNode()
    
    var cancelButton = ASButtonNode()
    var cancelButtonCounterWeight = ASImageNode()
    
    override init() {
        super.init()
        
        CommentsSectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            let commentSize = CGSize(width: UIScreen.main.bounds.width, height: 75)
            flowLayout.itemSize = commentSize
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 10
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            return collection
        }()
        
        setupNodes()
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return globalUsernameData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return CommentCellData(ProfileImage: (globalProfileImageData[indexPath.row]), Username: (globalUsernameData[indexPath.row]), Comment: (globalCommentData[indexPath.row]), LikeCount: (globalLikeCountData[indexPath.row]), TimeStamp: (globalUsernameData[indexPath.row]), NumberOfReplys: (self?.commentSectionNumberOfReplysData[indexPath.row])!)
        }
    }
    
    func setupNodes() {
        separatorLineTop.backgroundColor = .white
        separatorLineTop.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1)
        
        separatorLineBottom.backgroundColor = .white
        separatorLineBottom.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1)
        
        cancelButtonCounterWeight.zPosition = 3
        cancelButtonCounterWeight.frame.size = CGSize(width: 30, height: 30)
        cancelButtonCounterWeight.style.preferredSize = CGSize(width: 30, height: 30)
        
        cancelButton.setImage(UIImage(named: "XButton"), for: .normal)
        cancelButton.zPosition = 3
        cancelButton.frame.size = CGSize(width: 30, height: 30)
        cancelButton.style.preferredSize = CGSize(width: 30, height: 30)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), forControlEvents: .touchUpInside)
        
        CommentsSectionNode.dataSource = self
        CommentsSectionNode.delegate = self
        CommentsSectionNode.backgroundColor = .clear
        CommentsSectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        
        comment.delegate = self
        comment.attributedPlaceholderText = .init(string: "Add a comment...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        comment.backgroundColor = .clear
        comment.style.preferredSize = .init(width: 270, height: 50)
        comment.textContainerInset = .init(top: 5, left: 10, bottom: 0, right: 0)
        comment.enablesReturnKeyAutomatically = true
        comment.tintColor = UIColor().soundbarColorScheme()
        comment.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        comment.alpha = 0.75
   
        commentBox.style.preferredSize = .init(width: 340, height: 30)
        commentBox.cornerRadius = 8
        commentBox.backgroundColor = UIColor(red: 0.125, green: 0.125, blue: 0.125, alpha: 1)

        commentBackground.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 70)
        commentBackground.backgroundColor = UIColor().cellBackgroundGray()
        
        addHeaderText.attributedText = NSAttributedString(string: "Comments(465)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
    }
    
    @objc private func cancelButtonClicked() {
        self.closestViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let centerHeaderEverything = ASStackLayoutSpec(direction: .horizontal,
                                                       spacing: 100,
                                                       justifyContent: .center,
                                                       alignItems: .center,
                                                       children: [cancelButtonCounterWeight, addHeaderText, cancelButton])
    
        let commentVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                     spacing: 18,
                                                     justifyContent: .center,
                                                     alignItems: .center,
                                                     children: [centerHeaderEverything, CommentsSectionNode])
        return commentVerticalStack
    }
}


