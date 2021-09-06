//
//  MessageMediaViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import Foundation
import UIKit

class MessageMediaViewController: ASDKViewController<BaseNode> {
    
    var messageMediaFeed: MessageMediaFeed!
    
    override init() {
        super.init(node: BaseNode())
    
        messageMediaFeed = MessageMediaFeed()
        self.node.addSubnode(messageMediaFeed)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { [weak self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self!.messageMediaFeed)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

