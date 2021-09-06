//
//  ShareFeedPopUpViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewPlaylistPopUpViewController: ASDKViewController<BaseNode> {
        
    override init() {
        super.init(node: BaseNode())
        
        self.view.backgroundColor = UIColor().cellBackgroundGray()
        
        let playlistContent = NewPlaylistDisplay()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistContent)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

