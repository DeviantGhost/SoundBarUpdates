//
//  PlaylistControls.swift
//  SoundBar
//
//  Created by Justin Cose on 7/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

var didCreatePlaylist = false

class PlaylistControls: BaseNode {

    var cancelBox = ASImageNode()
    var doneBox = ASImageNode()
    
    var cancelText = ASTextNode()
    var doneText = ASTextNode()
    
    override init() {
        super.init()

        setupNodes()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let centerCancel = ASCenterLayoutSpec(centeringOptions: .XY, child: cancelText)
        let centerDone = ASCenterLayoutSpec(centeringOptions: .XY, child: doneText)
        
        let cancelOverlay = ASOverlayLayoutSpec(child: cancelBox, overlay: centerCancel)
        let doneOverlay = ASOverlayLayoutSpec(child: doneBox, overlay: centerDone)

        let fullStack = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: UIScreen.main.bounds.width / 20,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [cancelOverlay, doneOverlay])
        
        return fullStack
    }

    private func setupNodes() {
        cancelBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2.5, height: 50)
        cancelBox.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        cancelBox.addTarget(self, action: #selector(cancelClicked), forControlEvents: .touchUpInside)
        cancelBox.cornerRadius = 10
        
        doneBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 2.5, height: 50)
        doneBox.backgroundColor = UIColor().soundbarColorScheme()
        doneBox.addTarget(self, action: #selector(doneClicked), forControlEvents: .touchUpInside)
        doneBox.cornerRadius = 10

        cancelText.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        doneText.attributedText = NSAttributedString(string: "Done", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
    }

    @objc func cancelClicked() {
        currentlyCreatingPlaylist = false
        songsCellData = [SongPresentation]()
        playlistNameGlobal = ""
        songsCellData = []
        songsCellArray = []
        songCellCurrent = []
        isEditingNewPlaylist = false
        iconsSwitched = false
        didCreatePlaylist = false

        NotificationCenter.default.post(name: Notification.Name("cancelClicked"), object: nil)
    }

    @objc func doneClicked() {
        if didCreatePlaylist == false {
            currentlyCreatingPlaylist = false
            didCreatePlaylist = true
            NotificationCenter.default.post(name: Notification.Name("playlistCreate"), object: nil)
        }
        else {
            currentlyCreatingPlaylist = false
            playlistEdit = true
            NotificationCenter.default.post(name: Notification.Name("playlistOpen"), object: nil)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}
