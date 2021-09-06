//
//  FollowPageCells.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FollowPageCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var audioPlayer: AudioHandler!
    var profile: ProfileHeader!
    
    override init() {
        super.init()

        self.backgroundColor = .clear
        
        if currentTab == "Followers" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000) // check this height out
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
    
        else if currentTab == "Following" {
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000) // check this height out
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
    
        else {
        
            collectionNode = {
                let flowLayout = UICollectionViewFlowLayout()
                flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000) // check this height out
                flowLayout.scrollDirection = .vertical
                flowLayout.minimumLineSpacing = 0
                
                let collection = ASCollectionNode(collectionViewLayout: flowLayout)
                collection.backgroundColor = .clear
                return collection
            }()
        }
        
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
                return FollowCollectionData()
        }
    }

    private func setupNodes() {
        if currentTab == "Followers" {
            collectionNode.backgroundColor = UIColor().backgroundGray()
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1000)
            collectionNode.layoutMargins = UIEdgeInsets.zero
            collectionNode.borderWidth = 0
            collectionNode.borderColor = UIColor.clear.cgColor
        }
    
        else if currentTab == "Following" {
            collectionNode.backgroundColor = UIColor().backgroundGray()
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1000)
            collectionNode.layoutMargins = UIEdgeInsets.zero
            collectionNode.borderWidth = 0
            collectionNode.borderColor = UIColor.clear.cgColor
        }

        else {
            collectionNode.backgroundColor = UIColor().backgroundGray()
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1000)
            collectionNode.layoutMargins = UIEdgeInsets.zero
            collectionNode.borderWidth = 0
            collectionNode.borderColor = UIColor.clear.cgColor
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
