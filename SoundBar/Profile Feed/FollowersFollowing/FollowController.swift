//
//  FollowController.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FollowController: ASDKViewController<BaseNode> {
    
    var followFeed: FollowFeed!
    
    override init() {
        super.init(node: BaseNode())
        
        followFeed = FollowFeed()
        self.node.addSubnode(followFeed)
        self.node.backgroundColor = .black
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.followFeed)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
