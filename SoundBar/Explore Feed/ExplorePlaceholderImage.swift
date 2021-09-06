//
//  ExplorePlaceholderImage.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-07.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ExplorePlaceholderImage: BaseCellNode {
    
    let collectionImage = ASNetworkImageNode()

    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let collectionCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: collectionImage)
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: collectionCenter)
    }
    
    private func setupNodes() {
        collectionImage.url = URL(string: "https://upload.wikimedia.org/wikipedia/en/f/fd/DaBaby_-_Kirk.png")
        collectionImage.style.preferredSize = .init(width: 180, height: 180)
        collectionImage.cornerRadius = 180/2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
