//
//  LibrarySearch.swift
//  SoundBar
//
//  Created by Justin Cose on 7/15/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var searchOpen = false

class LibrarySearchTop: BaseCellNode, ASEditableTextNodeDelegate {
    
    var searchBoxBackground = ASImageNode()
    
    var searchText = ASEditableTextNode()
    
    var getHeightText = ASEditableTextNode()

    var newPlaylistCircle = ASImageNode()
    var newPlaylistIcon = ASImageNode()
    
    var keyboardHeight: CGFloat!
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    

        setUpNodes()
    }
    
    override func didEnterVisibleState() {
        self.view.addSubnode(self.searchText)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        print("Keyboard show notification two")
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
    }
    
    func setUpNodes() {
        searchText.delegate = self
        searchText.attributedPlaceholderText = .init(string: "Search your library", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        searchText.backgroundColor = .clear
        searchText.style.preferredSize = .init(width: 210, height: "Search your library".sizeOfString(font: UIFont.boldSystemFont(ofSize: 16)).height)
        searchText.textContainerInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        searchText.enablesReturnKeyAutomatically = true
        searchText.tintColor = UIColor().soundbarColorScheme()
        searchText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        searchText.alpha = 0.75

        searchBoxBackground.style.preferredSize = .init(width: 310, height: 40)
        searchBoxBackground.cornerRadius = 8
        searchBoxBackground.backgroundColor = UIColor().buttonsGray()
        
        newPlaylistCircle.style.preferredSize = CGSize(width: 35, height: 35)
        newPlaylistCircle.cornerRadius = 35/2
        newPlaylistCircle.backgroundColor = UIColor().buttonsGray()
        newPlaylistCircle.addTarget(self, action: #selector(addNewPlaylist), forControlEvents: .touchUpInside)
        
        newPlaylistIcon.image = UIImage(named: "AddPlaylistIcon")
        newPlaylistIcon.style.preferredSize = CGSize(width: 30, height: 30)
    }
    
    @objc func addNewPlaylist() {
        DispatchQueue.main.async {
            self.view.addSubnode(self.getHeightText)
            self.getHeightText.becomeFirstResponder()
            self.getHeightText.resignFirstResponder()
            self.getHeightText.removeFromSupernode()
        
            popUpHeight = ((self.keyboardHeight + 230) / UIScreen.main.bounds.height)
            popUpPosition = 1 - ((self.keyboardHeight + 230) / UIScreen.main.bounds.height)
            NotificationCenter.default.post(name: Notification.Name("addNewPlaylist"), object: nil)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let newPlaylistOverlay = ASOverlayLayoutSpec(child: newPlaylistCircle, overlay: newPlaylistIcon)
        
        let searchInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: searchText)
        let searchLayout = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: searchInset)
        let searchOverlay = ASOverlayLayoutSpec(child: searchBoxBackground, overlay: searchLayout)
        
        let topStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [searchOverlay, newPlaylistOverlay])
        
        return topStack
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        newPlaylistCircle.springRotate()
        newPlaylistIcon.springRotate()
        
        newPlaylistCircle.removeTarget(self, action: #selector(addNewPlaylist), forControlEvents: .touchUpInside)
        newPlaylistCircle.addTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
        
        NotificationCenter.default.post(name: Notification.Name("activateSearchBar"), object: nil)
    }
    
    @objc func clearSearchBar() {
        NotificationCenter.default.post(name: Notification.Name("clearLibrarySearchBar"), object: nil)
        newPlaylistCircle.closeSpringRotate()
        newPlaylistIcon.closeSpringRotate()
        
        newPlaylistCircle.removeTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
        newPlaylistCircle.addTarget(self, action: #selector(addNewPlaylist), forControlEvents: .touchUpInside)
    }
    
    @objc func scrollClearSearchBar() {
        newPlaylistCircle.closeSpringRotate()
        newPlaylistIcon.closeSpringRotate()
        
        newPlaylistCircle.removeTarget(self, action: #selector(clearSearchBar), forControlEvents: .touchUpInside)
        newPlaylistCircle.addTarget(self, action: #selector(addNewPlaylist), forControlEvents: .touchUpInside)
    }
    
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
  
    }
    
    
    @objc func searchCircleClicked() {
     
    }
    
    @objc func backButtonClicked() {
        if self.closestViewController?.navigationController == nil {
            self.closestViewController?.dismiss(animated: true, completion: nil)
        }
        else {
            self.closestViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func profileButtonClicked() {
      
    }
}


extension ASImageNode {
    func shrinkSearch() {
        let shrinkSearchBar = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkSearchBar.fillMode = .forwards
        shrinkSearchBar.isRemovedOnCompletion = false
        shrinkSearchBar.fromValue = self.frame.size.width
        shrinkSearchBar.toValue = 150
        shrinkSearchBar.duration = 0.175
        self.layer.add(shrinkSearchBar, forKey: "bounds")
    }
    func growSearch() {
        let growSearchBar = CABasicAnimation(keyPath: "bounds.size.width")
        growSearchBar.fillMode = .forwards
        growSearchBar.isRemovedOnCompletion = false
        growSearchBar.fromValue = self.frame.size.width
        growSearchBar.toValue = 200
        growSearchBar.duration = 0.175
        self.layer.add(growSearchBar, forKey: "bounds")
    }
}

extension ASImageNode {
    func springRotate() {
        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * 1.25)
        rotation.duration = 5
        rotation.repeatCount = .zero
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    func closeSpringRotate() {
        let rotation: CASpringAnimation = CASpringAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = CGFloat(Double.pi * -1)
        rotation.duration = 5
        rotation.repeatCount = .zero
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}
