//
//  ArtistProfileFeed.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-11-30.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ArtistProfileFeed: ASDKViewController<ASDisplayNode> {
    
    var profile: ProfileFeed!
    
    init(user: String) {
        super.init(node: BaseNode())
        profile = ProfileFeed(user: user)

        self.node.addSubnode(profile)
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 47.0, left: 0, bottom: 0, right: 0), child: self.profile)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
