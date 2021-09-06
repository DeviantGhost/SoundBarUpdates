//
//  BaseNode.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class BaseNode: ASDisplayNode {
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
    }
}
