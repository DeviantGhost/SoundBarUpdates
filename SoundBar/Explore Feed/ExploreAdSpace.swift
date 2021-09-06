//
//  ExploreAdSpace.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-03.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class ExploreAdSpace: BaseCellNode {
    
//    let searchBar = ASDisplayNode { () -> UIView in
//        let search = UISearchBar()
//    }
    let backgroundImage = ASImageNode()
    let exampleImg = ASImageNode()
    
    override init() {
        super.init()
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: backgroundImage, overlay: exampleImg)
    }
    
    private func setupNodes() {
        backgroundImage.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6)
        
        exampleImg.style.preferredSize = .init(width: 100, height: 100)
        exampleImg.image = .init(imageLiteralResourceName: "benzo")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
