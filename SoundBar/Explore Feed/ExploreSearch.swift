//
//  ExploreSearch.swift
//  SoundBar
//
//  Created by Justin Cose on 2020-09-09.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ExploreSearch: BaseCellNode, ASEditableTextNodeDelegate {

    var searchBoxBackground = ASImageNode()
    var searchText = ASEditableTextNode()
    var cancelText = ASTextNode()

    override init() {
        super.init()
<<<<<<< Updated upstream
        setupNodes()
        NotificationCenter.default.addObserver(self, selector: #selector(touchesDidBegan), name: NSNotification.Name("touchesDidBegan"), object: nil)
        FirebaseHandler().homeFeedDownload()
        self.backgroundColor = .black
=======

        setUpNodes()
>>>>>>> Stashed changes
    }

    override func didEnterVisibleState() {
        self.view.addSubnode(self.searchText)
        
        cancelText.frame = CGRect(x: UIScreen.main.bounds.width - 10, y: 12, width: 55, height: 45)
        cancelText.zPosition = 11
        view.addSubnode(cancelText)
    }

    func setUpNodes() {
        searchText.delegate = self
        searchText.attributedPlaceholderText = .init(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        searchText.backgroundColor = .clear
        searchText.style.preferredSize = .init(width: 270, height: "Search".sizeOfString(font: UIFont.boldSystemFont(ofSize: 16)).height)
        searchText.textContainerInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        searchText.enablesReturnKeyAutomatically = true
        searchText.tintColor = UIColor().soundbarColorScheme()
        searchText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        searchText.alpha = 0.75

        searchBoxBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 45)
        searchBoxBackground.cornerRadius = 8
        searchBoxBackground.backgroundColor = UIColor().cellBackgroundGray()
        searchBoxBackground.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        
        cancelText.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        cancelText.addTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerSearch = ASCenterLayoutSpec(centeringOptions: .Y, child: searchText)
        let searchOverlay = ASOverlayLayoutSpec(child: searchBoxBackground, overlay: centerSearch)
        return searchOverlay
    }

    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        if searchOpen == false{
            exploreSections = 1
            
            searchBoxBackground.activateHomeSearch()
            
            cancelText.activateHomeSearch()
            cancelText.position.x -= 65
            cancelText.addTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
        
            NotificationCenter.default.post(name: Notification.Name("activateExploreBar"), object: nil)
            
            searchOpen = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }

    @objc func clearSearchBar() {
        if searchOpen {
            searchBoxBackground.deActivateHomeSearch()
            
            cancelText.deActivateHomeSearch()
            cancelText.position.x += 65
            cancelText.removeTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)

            NotificationCenter.default.post(name: Notification.Name("clearSearchBar"), object: nil)
            
            self.searchText.isUserInteractionEnabled = false
            
            searchOpen = false

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.searchText.isUserInteractionEnabled = true
            }
        }
    }
}

extension ASImageNode {
    func activateHomeSearch() {
        let initialBounds = self.frame.size.width
        let move = CABasicAnimation(keyPath: "bounds.size.width")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds - 65
        move.duration = 0.175
        self.layer.add(move, forKey: "bounds")
    }
    func deActivateHomeSearch() {
        let initialBounds = self.frame.size.width - 65
        let move = CABasicAnimation(keyPath: "bounds.size.width")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds + 65
        move.duration = 0.175
        self.layer.add(move, forKey: "bounds")
    }
}

extension ASTextNode {
    func activateHomeSearch() {
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds - 65
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
    func deActivateHomeSearch() {
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds + 65
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
}

extension ASImageNode {
    func activateHomeSearchBox() {
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds - 65
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
    func deActivateHomeSearchBox() {
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds + 65
        move.duration = 0.175
        self.layer.add(move, forKey: "position.y")
    }
}
