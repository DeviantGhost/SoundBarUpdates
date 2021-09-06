//
//  ProfileTracksOption.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-27.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

class ProfileTracksOption: BaseNode {
    
    let tracksNode = ASButtonNode()
    let libraryNode = ASButtonNode()
    let backgroundImageNode = ASImageNode()
    let imageShadeNode = ASImageNode()
    var isArtist: (Bool, Bool)!
    
    init(isArt: (Bool, Bool)) {
        super.init()
        setupNodes()
        isArtist = isArt
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var hStackButtons = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 150,
                                              justifyContent: .center,
                                              alignItems: .stretch,
                                              children: [libraryNode, tracksNode])
        if isArtist.0 {
            hStackButtons = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .stretch,
                                              children: [tracksNode])
        } else if isArtist.1 {
            hStackButtons = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .stretch,
                                              children: [libraryNode])
        }
        let backgroundInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 10), child: backgroundImageNode)
        let backgroundOverlay = ASOverlayLayoutSpec(child: backgroundInset, overlay: hStackButtons)
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 10, right: 0), child: backgroundOverlay)
    }
    
    private func setupNodes() {
        tracksNode.setTitle("Tracks", with: UIFont.boldSystemFont(ofSize: 16), with: .white, for: .normal)
        libraryNode.setTitle("Library", with: UIFont.boldSystemFont(ofSize: 16), with: .white, for: .normal)
        
        tracksNode.addTarget(self, action: #selector(tracksButtonClicked), forControlEvents: .touchUpInside)
        libraryNode.addTarget(self, action: #selector(libraryButtonClicked), forControlEvents: .touchUpInside)

        backgroundImageNode.backgroundColor = .black
        backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 40)
        backgroundImageNode.borderColor = UIColor.white.cgColor
        backgroundImageNode.borderWidth = 1
        backgroundImageNode.cornerRadius = 7
    }
    
    @objc private func tracksButtonClicked() {
        if !isArtist.0 {
            NotificationCenter.default.post(name: NSNotification.Name("tracksButtonClicked"), object: nil)
        }
    }
    
    @objc private func libraryButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("libraryButtonClicked"), object: nil)
    }
}
