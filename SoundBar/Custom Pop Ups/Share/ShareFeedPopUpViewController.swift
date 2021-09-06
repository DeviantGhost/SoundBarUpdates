//
//  ShareFeedPopUpViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var shareContentView = false
var shareHeight: CGFloat!

class ShareFeedPopUpViewController: ASDKViewController<BaseNode> {
    
    var share: ShareFeedPopUp!
    var shareContent: ShareFeedPopUpFeed!
    
    override init() {
        super.init(node: BaseNode())
        
        self.view.backgroundColor = UIColor().cellBackgroundGray()
        
        share = ShareFeedPopUp()
        shareContent = ShareFeedPopUpFeed()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            if shareContentView == false {
                return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.shareContent)
            }
            else {
                return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.share)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

