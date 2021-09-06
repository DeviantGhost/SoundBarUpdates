//
//  ProfileHomeCellData.swift
//  SoundBar
//
//  Created by Justin Cose on 7/8/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class ProfileHomeCellData: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var data: [String: Any] = [:]
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    var isArtist: Bool!
    var profile: ProfileHeader!
    
    init(type: String!, data: [String: Any], currentPage: String!, audio: AudioHandler, animationHandle: SongsAnimationHandler, isArt: Bool, profile: ProfileHeader) {
        super.init()
        
        self.data = data
        audioPlayer = audio
        animationHandler = animationHandle
        isArtist = isArt
        self.profile = profile
        
        self.backgroundColor = .clear
   
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 700) // check this height out
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
                return RepostsCollectionNode(tab: currentTab, cellData: self!.data, audio: self!.audioPlayer, animationHandle: self!.animationHandler, isArt: self!.isArtist)
        }
    }
    
    private func setupNodes() {
            collectionNode.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
            collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 700)
            collectionNode.layoutMargins = UIEdgeInsets.zero
            collectionNode.borderWidth = 0
            collectionNode.borderColor = UIColor.clear.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

