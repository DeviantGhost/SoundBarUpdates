//
//  SendFeedViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/6/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class SendFeedViewController: ASDKViewController<BaseNode> {
    
    var sendFeed: SendFeed!
    
    override init() {
        super.init(node: BaseNode())
        
        sendFeed = SendFeed()
        self.node.addSubnode(sendFeed)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.sendFeed)
        }
        
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

