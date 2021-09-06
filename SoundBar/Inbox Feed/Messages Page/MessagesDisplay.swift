//
//  MessagesDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 3/17/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//


import AsyncDisplayKit
import AVFoundation
import UIKit

class MessagesDisplay: BaseNode, ASCollectionDelegate, ASCollectionDataSource, UICollectionViewDelegateFlowLayout {
    
    var fullSongDataSource = hotBarsDataSourceStatic
    
    var CommentsSectionNode: ASCollectionNode!
    
    override init() {
        super.init()
        
        fullSongDataSource.shuffle()
        
        CommentsSectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            let commetSize = CGSize(width: UIScreen.main.bounds.width, height: 75)
            flowLayout.collectionView?.showsVerticalScrollIndicator = false
            flowLayout.itemSize = commetSize
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
            return globalProfileImageData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            return MessagesCellData(ProfileImage: (globalProfileImageData[indexPath.row]), Username: (globalUsernameData[indexPath.row]), Comment: (globalCommentData[indexPath.row]), TimeStamp: (globalTimeStampData[indexPath.row]))
        }
    }
    
    func setupNodes() {
        CommentsSectionNode.dataSource = self
        CommentsSectionNode.delegate = self
        CommentsSectionNode.backgroundColor = UIColor().backgroundGray()
        CommentsSectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
     }
    
    @objc private func cancelButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("cancelCommentPopUp"), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let messageDisplay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: CommentsSectionNode)
        return messageDisplay
    }
}

