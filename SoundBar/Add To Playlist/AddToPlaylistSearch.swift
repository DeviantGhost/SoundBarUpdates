//
//  AddToPlaylistSearch.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AddToPlaylistSearch: BaseCellNode, ASEditableTextNodeDelegate {
    
    var searchText = ASEditableTextNode()
    var searchBoxBackground = ASImageNode()
    
    var cancelIcon = ASImageNode()
    var cancelIconCircle = ASImageNode()
    
    override init() {
        super.init()
        
        setUpNodes()
        
    }
    
    override func didEnterVisibleState() {
        self.view.addSubnode(self.searchText)
    }
    
    func setUpNodes() {
        searchText.delegate = self
        searchText.attributedPlaceholderText = .init(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        searchText.backgroundColor = .clear
        searchText.style.preferredSize = .init(width: 270, height: 50)
        searchText.textContainerInset = .init(top: 8, left: 25, bottom: 0, right: 0)
        searchText.enablesReturnKeyAutomatically = true
        searchText.tintColor = UIColor().soundbarColorScheme()
        searchText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        searchText.alpha = 0.75
    
        searchBoxBackground.frame = CGRect(x: 0, y: 0, width: 270, height: 50)
        searchBoxBackground.cornerRadius = 8
        searchBoxBackground.backgroundColor = UIColor().buttonsGray()
        
        cancelIcon.image = UIImage(named: "cancelIconSearchX")
        cancelIcon.style.preferredSize = CGSize(width: 20, height: 20)
        
        cancelIconCircle.style.preferredSize = CGSize(width: 27.5, height: 27.5)
        cancelIconCircle.cornerRadius = 30/2
        cancelIconCircle.addTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let cancelIconOverlay = ASOverlayLayoutSpec(child: cancelIconCircle, overlay: cancelIcon)
        
        let searchInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: searchText)
        let searchLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: searchInset)
        
        let searchX = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 78,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [searchLayout, cancelIconOverlay])
        
        let stackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 15), child: searchX)
        let searchOverlay = ASOverlayLayoutSpec(child: searchBoxBackground, overlay: stackInset)
       
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: searchOverlay)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    
    }
    
    @objc func clearSearchBar() {
        NotificationCenter.default.post(name: Notification.Name("clearSearchBar"), object: nil)
    }
    
}

