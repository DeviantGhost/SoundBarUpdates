//
//  SendCells.swift
//  SoundBar
//
//  Created by Justin Cose on 8/7/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class SendCells: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!
    
    var followerNames = ["Charlie", "Katie L", "Carson", "Ryan R", "Carlon R", "Austin T", "Grace Dowser", "Jack S", "John Smith", "Logan Dain", "Danesh", "Eric Issakson", "Lukas Theo", "Ari Fritz", "Jake Druckman", "Nicole R", "James", "Rachel R", "Oliver Dover", "Justin", "Ray", "Lia Oakley", "Kate Sear", "Faye", "Liam Conlon", "Anna Lynn", "Kaitlyn", "Aiden", "Mick Swanson", "Ethan"]
    
    var followerUserames = ["charlieeiseman", "katielamont", "carsonsherwood", "ryanthepersian", "carlonrosales", "austintrayen", "gracedowser", "jacksuvari", "johnsmith", "logandain", "daneshraj", "ericissakson", "lukastheo", "arifritz", "jackdruckman", "nicolerazdolsky", "jamesleroy", "rachrylie", "olivercdover", "justinhammond", "raydelio", "liaoakley", "ksear", "frodgers", "liamconlon", "annatlynn", "kaitlynrock", "aidenkendo", "mickswanson", "ethanwerkinoff"]

    var followImageData = ["commentsPfp2", "commentsPfp3", "commentsPfp4", "commentsPfp5", "commentsPfp6", "commentsPfp7", "commentsPfp8", "commentsPfp9", "commentsPfp10", "commentsPfp11", "commentsPfp12", "commentsPfp13", "commentsPfp14", "commentsPfp13", "commentsPfp16", "commentsPfp17", "commentsPfp18", "commentsPfp19", "commentsPfp20", "commentsPfp21", "commentsPfp22", "commentsPfp24", "commentsPfp25", "commentsPfp26", "commentsPfp27", "commentsPfp28", "commentsPfp27", "commentsPfp28", "commentsPfp29", "commentsPfp32", "commentsPfp33", "commentsPfp34", "commentsPfp35", "commentsPfp36", "commentsPfp37", "commentsPfp38", "IMG_4920.jpg", "commentsPfp40", "commentsPfp41", "commentsPfp42", "commentsPfp43", "commentsPfp44", "commentsPfp45", "commentsPfp46", "commentsPfp47", "commentsPfp48", "commentsPfp49", "commentsPfp50", "commentsPfp1"]
    
    var audioPlayer: AudioHandler!

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
            collection.isPagingEnabled = false
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
            return 30
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return SendCell(followerNames: self!.followerNames[indexPath.row], followerUsernames: self!.followerUserames[indexPath.row], followImageData: globalProfileImageData[indexPath.row])
        }
    }
    
    func setupNodes() {
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 1000)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}
