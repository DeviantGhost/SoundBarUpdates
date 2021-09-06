//
//  EditProfileTop.swift
//  SoundBar
//
//  Created by Justin Cose on 6/16/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class EditProfileTop: BaseCellNode {
    
    var backButton = ASButtonNode()
    var backButtonCircle = ASImageNode()
    
    override init() {
        super.init()
        
        self.backgroundColor = .clear
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backOverlay = ASOverlayLayoutSpec(child: backButtonCircle, overlay: backButton)
        let backOverlayInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: backOverlay)
        return backOverlayInset
    }
    
    private func setupNodes() {
        backButtonCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backButtonCircle.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        backButtonCircle.cornerRadius = 17.5
        backButton.addTarget(self, action: #selector(backClicked), forControlEvents: .touchUpInside)
        backButton.zPosition = 10
        view.addSubnode(backButtonCircle)
        
        backButton.setImage(UIImage(named: "FollowBackButton"), for: .normal)
        backButton.style.preferredSize = CGSize(width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backClicked), forControlEvents: .touchUpInside)
        backButton.zPosition = 11
        view.addSubnode(backButton)
    }
    
    @objc private func backClicked() {
        self.closestViewController?.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

