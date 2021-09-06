//
//  ProfileController.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-08-06.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ProfileController: ASDKViewController<BaseNode> {
    
    var profile: ProfileFeed!
    
    override init() {
        super.init(node: BaseNode())
        profile = ProfileFeed()
        self.node.addSubnode(profile)
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.profile)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
