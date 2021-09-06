//
//  BetaWelcomeViewController.swift
//  SoundBar
//
//  Created by Justin Cose on 9/3/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class BetaWelcomeViewController: ASDKViewController<BaseNode> {
        
    override init() {
        super.init(node: BaseNode())
        
        self.view.backgroundColor = UIColor().topBackgroundGray()
        
        let welcomeDisplay = BetaWelcomeDisplay()
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 30, right: 0), child: welcomeDisplay)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


