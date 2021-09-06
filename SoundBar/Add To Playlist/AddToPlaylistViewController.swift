//
//  AddToPlaylistViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
import Foundation
import UIKit

class AddToPlaylistViewController: ASDKViewController<BaseNode> {
    
    var addToPlaylistPage: AddToPlaylistFeed!
    
    override init() {
        super.init(node: BaseNode())
    
        addToPlaylistPage = AddToPlaylistFeed()
        self.node.addSubnode(addToPlaylistPage)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { [weak self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self!.addToPlaylistPage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
