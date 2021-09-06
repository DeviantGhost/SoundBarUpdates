//
//  LibraryPopUpViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//


import AsyncDisplayKit
import Foundation
import UIKit

class LibraryPopUpViewController: ASDKViewController<BaseNode> {
    
    var explore: ExploreFeed!
    
    init(audio: AudioHandler) {
        super.init(node: BaseNode())
        
        explore = ExploreFeed(audio: audio)
        self.node.addSubnode(explore)
        self.node.backgroundColor = UIColor().backgroundGray()
        self.node.layoutSpecBlock = { [weak self] (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self!.explore)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

