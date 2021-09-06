//
//  MessageCellDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 3/21/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//


import AsyncDisplayKit
import AVFoundation
import UIKit

class MessageCellDisplay: BaseNode, ASCollectionDelegate, ASCollectionDataSource, UICollectionViewDelegateFlowLayout {

    var messagesDisplayNode: ASCollectionNode!

    var fullSongDataSource = hotBarsDataSourceStatic
    
    override init() {
        super.init()
        
        fullSongDataSource.shuffle()
        
        messagesDisplayNode = {
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
            return 1
    }
 
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
            return {
                
                return ASCellNode()
                
            }
    }
    
    func setupNodes() {
        messagesDisplayNode.dataSource = self
        messagesDisplayNode.delegate = self
        messagesDisplayNode.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        messagesDisplayNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
     }
    
    @objc private func cancelButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("cancelCommentPopUp"), object: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        let MessagesDisplay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: messagesDisplayNode)
        return MessagesDisplay
        
    }
    
}


