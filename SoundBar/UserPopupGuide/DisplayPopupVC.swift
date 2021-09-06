//
//  DisplayPopupVC.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-10.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class DisplayPopupVC: ASDKViewController<BaseNode> {
    
    let popup = FirstTimePopUpPager()
    
    override init() {
        super.init(node: BaseNode())
//        view.backgroundColor = .red
        self.node.addSubnode(popup)
        self.node.layoutSpecBlock = { (node, constrainedSize) in
            return ASInsetLayoutSpec(insets: .zero, child: self.popup)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
