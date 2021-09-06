//
//  FollowCollectionData.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class FollowCollectionData: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var cellType: String!
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    override init() {
        super.init()
        
        self.backgroundColor = .clear
    
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
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
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [collectionNode])
        return textStack
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return globalProfileImageData.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return FollowCells(followerNames: globalNameData[indexPath.row], followerUsernames: globalUsernameData[indexPath.row], followImageData: globalProfileImageData[indexPath.row])
        }
    }
    
    private func setupNodes() {
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1000)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
