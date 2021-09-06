//
//  ViewController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ViewController: ASDKViewController<BaseNode> {
    
    var screen: HomeFeed!
    
    init(space: CGFloat) {
        super.init(node: BaseNode())
        screen = HomeFeed(space: space)
        self.node.addSubnode(screen)
//        FirebaseHandler().handleUserArtworkUpload(profImageLink: "https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2020%2F04%2Fdababy-announces-new-album-blame-it-on-baby-release-date-2.jpg?quality=95&w=1170&cbr=1&q=90&fit=max", coverImageLink: "https://townsquare.media/site/812/files/2019/07/dababy-bet-experience-performance.jpg?w=1200", name: "dababy")
        self.node.backgroundColor = .black
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.screen)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
