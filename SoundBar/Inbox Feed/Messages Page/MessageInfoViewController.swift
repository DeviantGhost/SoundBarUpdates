//
//  MessageInfoViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/4/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MessageInfoViewController: ASDKViewController<BaseNode> {
    
    var messageInfoDisplay: MessageInfoDisplay!
    
    override init() {
        super.init(node: BaseNode())
        
        messageInfoDisplay = MessageInfoDisplay()
        self.node.addSubnode(messageInfoDisplay)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 520, right: 0), child: self.messageInfoDisplay)
        }
        
    }
    
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


