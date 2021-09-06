//
//  ExploreTrendingCellData.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-04.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ExploreTrendingCellData: BaseCellNode {
    
    let playlistImage = ASNetworkImageNode()

    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 1.5, bottom: 0, right: 1.5), child: playlistImage)
        return imageInset
    }
    
    private func setupNodes() {
        playlistImage.style.preferredSize = .init(width: 100, height: 100)
        playlistImage.contentMode = .scaleAspectFill
        playlistImage.url = URL(string: "https://pyxis.nymag.com/v1/imgs/a0c/94c/50205b986d1b86a03f90b2c49a5ee0d467-dababy.rsquare.w1200.jpg")
        playlistImage.borderWidth = 1
        playlistImage.borderColor = UIColor.white.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
