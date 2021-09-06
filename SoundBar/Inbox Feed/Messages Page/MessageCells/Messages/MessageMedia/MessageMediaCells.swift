//
//  MessageMediaCells.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MessageMediaCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    override init() {
        super.init()

        self.backgroundColor = .clear
    
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.width / 2) // check this height out
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
            
        collectionNode.delegate = self
        collectionNode.dataSource = self

        setupNodes()
       
    }
    
    override func didLoad() {
        collectionNode.view.showsVerticalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: collectionNode)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
   
            return ASCellNode()
            
        }
    }
    
    func setupNodes() {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}

