//
//  PlaylistCells.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AddToPlaylistCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    override init() {
        super.init()

        self.backgroundColor = .clear
    
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2.1, height: UIScreen.main.bounds.width / 2)
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
        return playlistsStatic.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return AddToPlaylistCell(playlist: playlistsStatic[indexPath.row])
        }
    }
    
    func setupNodes() {
        collectionNode.backgroundColor = UIColor().backgroundGray()
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1200) //Make Dynamic
        collectionNode.layoutMargins = UIEdgeInsets.zero
        collectionNode.borderWidth = 0
        collectionNode.borderColor = UIColor.clear.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}
