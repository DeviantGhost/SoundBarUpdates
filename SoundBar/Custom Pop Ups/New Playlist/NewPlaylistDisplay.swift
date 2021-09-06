//
//  ShareFeedPopUp.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var playlistPoppedUp = false
var currentlyCreatingPlaylist = Bool()
var playlistName = String()

class NewPlaylistDisplay: BaseNode, ASEditableTextNodeDelegate {
    
    var popUpBackground = ASImageNode()
    
    var createPlaylistTitle = ASTextNode()
    var privateText = ASTextNode()
    
    var buttonText = ASTextNode()
    var buttonBackground = ASImageNode()
    
    var nameText = ASEditableTextNode()
    var textUnderlinePlacement = ASImageNode()
    
    var privateButtonBackground = ASButtonNode()
    var privateButton = ASImageNode()
    
    override init() {
        super.init()
    
        setupNodes()
    }
    
    override func didEnterVisibleState() {
        DispatchQueue.main.async {
            self.nameText.becomeFirstResponder()
        }
        
        self.view.backgroundColor = UIColor().cellBackgroundGray()
    }
    

    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let privateButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: privateButton)
        let privateButtonFixed = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [privateButtonInset])

        let privateButtonOverlay = ASOverlayLayoutSpec(child: privateButtonBackground, overlay: privateButtonFixed)
        let privateStack = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: UIScreen.main.bounds.width / 1.5625,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [privateText, privateButtonOverlay])
        
        
        
        let nameTextStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 2,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [nameText, textUnderlinePlacement])
        
        let playlistStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 20,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [createPlaylistTitle, nameTextStack, privateStack])
        
        let playlistCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: playlistStack)
        let playlistOverlay = ASOverlayLayoutSpec(child: popUpBackground, overlay: playlistCenter)

        let buttonTextCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: buttonText)
        let buttonOverlay = ASOverlayLayoutSpec(child: buttonBackground, overlay: buttonTextCenter)

        let popUpVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .start,
                                                   alignItems: .center,
                                                   children: [playlistOverlay, buttonOverlay])
        
        return popUpVerticalStack
    }
    
   
    
    func setupNodes() {
        popUpBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        
        createPlaylistTitle.attributedText = NSAttributedString(string: "Create A Playlist", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        nameText.delegate = self
        nameText.attributedPlaceholderText = .init(string: "Playlist Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        nameText.backgroundColor = .clear
        nameText.style.preferredSize = .init(width: 250, height: 30)
        nameText.textContainerInset = .init(top: 6, left: 0, bottom: 0, right: 0)
        nameText.enablesReturnKeyAutomatically = true
        nameText.tintColor = UIColor().soundbarColorScheme()
        nameText.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        nameText.alpha = 0.75
        
        textUnderlinePlacement.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textUnderlinePlacement.style.preferredSize = CGSize(width: 250, height: 1)
        
        privateText.attributedText = NSAttributedString(string: "Private", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        
        privateButton.style.preferredSize = CGSize(width: 20, height: 20)
        privateButton.anchorPoint = CGPoint(x: 0, y: 0.5)
        privateButton.cornerRadius = 20/2
        privateButton.backgroundColor = .white
        
        privateButtonBackground.style.preferredSize = CGSize(width: 40, height: 20)
        privateButtonBackground.cornerRadius = 20/2
        privateButtonBackground.backgroundColor = UIColor().backgroundGray()
        privateButtonBackground.addTarget(self, action: #selector(privateClicked), forControlEvents: .touchUpInside)
        
        buttonText.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        
        buttonBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
        buttonBackground.backgroundColor = UIColor().backgroundGray()
        buttonBackground.addTarget(self, action: #selector(cancelButtonClicked), forControlEvents: .touchUpInside)
    }
    
    @objc func privateClicked() {
        if privateButtonBackground.isSelected == false {
            privateButtonBackground.backgroundColor = UIColor().soundbarColorScheme()
            privateButtonBackground.isSelected = true
            privateButton.activatePrivate()
            privateButton.position.x += 20
        }
        else{
            privateButtonBackground.backgroundColor = UIColor().backgroundGray()
            privateButtonBackground.isSelected = false
            privateButton.deActivatePrivate()
            privateButton.position.x -= 20
        }
    }
    
    @objc func cancelButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("dismissNewPlaylist"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("cancelClicked"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("cancelSharePopUp"), object: nil)

        playlistNameGlobal = ""
        nameText.attributedText = nil
        currentPlaylistName = ""
    }
    
    @objc func createNewPlaylist() {
        NotificationCenter.default.post(name: Notification.Name("cancelSharePopUp"), object: nil)

        currentlyCreatingPlaylist = true

        NotificationCenter.default.post(name: Notification.Name("createNewPlaylist"), object: nil)

        isEditingNewPlaylist = true
        iconsSwitched = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
    public func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        if editableTextNode.attributedText?.string != "" && editableTextNode.attributedText?.string != nil {
            currentPlaylistName = editableTextNode.attributedText!.string
        }
        editableTextNode.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
    }
    
    public func editableTextNodeDidUpdateText(_ editableTextNode: ASEditableTextNode){
        if editableTextNode.attributedText?.string != "" && editableTextNode.attributedText?.string != nil {
            buttonText.attributedText = NSAttributedString(string: "Create", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
            
            buttonBackground.backgroundColor = UIColor().soundbarColorScheme()
            buttonBackground.removeTarget(self, action: nil, forControlEvents: .allEvents)
            buttonBackground.addTarget(self, action: #selector(createNewPlaylist), forControlEvents: .touchUpInside)
        }
        else {
            buttonText.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
            
            buttonBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
            buttonBackground.backgroundColor = UIColor().backgroundGray()
            buttonBackground.removeTarget(self, action: nil, forControlEvents: .allEvents)
            buttonBackground.addTarget(self, action: #selector(cancelButtonClicked), forControlEvents: .touchUpInside)
        }
    }
    
    override func didExitVisibleState() {
        self.closestViewController?.dismiss(animated: false, completion: nil)
        DispatchQueue.main.async {
            self.nameText.resignFirstResponder()
        }
    }
}

extension ASImageNode {
    func activatePrivate() {
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds + 20
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
    func deActivatePrivate(){
        let initialBounds = self.position.x
        let move = CABasicAnimation(keyPath: "position.x")
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialBounds
        move.toValue = initialBounds - 20
        move.duration = 0.175
        self.layer.add(move, forKey: "position.x")
    }
}
