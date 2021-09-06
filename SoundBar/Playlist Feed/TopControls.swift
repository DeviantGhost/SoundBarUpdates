//
//  TopControls.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-2-26.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

class TopControls: BaseNode {
    
    var backgroundFrame =  ASImageNode()
    var backButton = ASButtonNode()
    var addButton = ASButtonNode()
    var moreButton = ASButtonNode()

    var backCircle = ASImageNode()
    var backIcon = ASImageNode()
    
    var rightButton = ASImageNode()
    var doneIcon = ASImageNode()
    
    weak var delegate : PlaylistsCellDelegate?
    var currentCell = [String: AnyObject]()

    var added = false

    override init() {
        super.init()

        NotificationCenter.default.addObserver(self, selector: #selector(editPlaylistCreate), name: NSNotification.Name("playlistCreate"), object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(editPlaylist), name: NSNotification.Name("editPlaylist"), object: nil )

        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let backOverlay = ASOverlayLayoutSpec(child: backCircle, overlay: backIcon)
        let moreOverlay = ASOverlayLayoutSpec(child: rightButton, overlay: doneIcon)

        
        let fullDisplay = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: UIScreen.main.bounds.width / 1.5,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [backOverlay, moreOverlay])
    
        let display = ASOverlayLayoutSpec(child: backgroundFrame, overlay: fullDisplay)

        return display
    }
    
    private func setupNodes() {
        backIcon.image = UIImage(named: "FollowBackButton")
        backIcon.style.preferredSize = .init(width: 30, height: 30)
        backIcon.contentMode = .scaleAspectFill
        
        backCircle.style.preferredSize = CGSize(width: 30, height: 30)
        backCircle.cornerRadius = 30/2
        backCircle.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        backCircle.addTarget(self, action: #selector(backButtonClicked), forControlEvents: .touchUpInside)
        
        rightButton.style.preferredSize = CGSize(width: 30, height: 30)
        rightButton.cornerRadius = 30/2
        rightButton.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)
        rightButton.addTarget(self, action: #selector(sharePopUp), forControlEvents: .touchUpInside)
        
        backgroundFrame.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        backgroundFrame.backgroundColor = .clear
        
        if (playlistEdit) {
            doneIcon.image = UIImage(named: "checkMarkIconYellow")
            doneIcon.addTarget(self, action: #selector(doneButtonClicked), forControlEvents: .touchUpInside)
        }
        
        else {
            if currentlyCreatingPlaylist {
                doneIcon.image = UIImage(named: "")
            }
            else{
                doneIcon.image = UIImage(named: "MoreIconCircles")
                doneIcon.addTarget(self, action: #selector(sharePopUp), forControlEvents: .touchUpInside)
            }
        }
    }
    
    @objc func backButtonClicked() {
        playlistOpened = false
        self.closestViewController?.navigationController?.popViewController(animated: true)
   
        if playlistEdit == true {
            currentlyCreatingPlaylist = true
            NotificationCenter.default.post(name: Notification.Name("switchIconToAdd"), object: nil)

        }
    }
    
    @objc func sharePopUp() {
        moreType = "Playlist"
        
        titleOneGlobal = "Playlist #2"
        titleTwoGlobal = "Created by: @artistuser"
        contentImageGlobal = "ComingInHotImage"

        popUpHeight = (410 / UIScreen.main.bounds.height)
        popUpPosition = 1 - (410 / UIScreen.main.bounds.height)
        NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
    }
    
    @objc func addButtonClicked() {
        if added == false {
            addButton.setImage(UIImage(named: "AddButton"), for: .normal)
            added = true
        }
        else {
            addButton.setImage(UIImage(named: "AddedPlaylist"), for: .normal)
            added = false
        }
    }
    
    @objc func editPlaylistCreate(){
        doneIcon.image = UIImage(named: "checkMarkIconYellow")
        doneIcon.removeTarget(self, action: nil, forControlEvents: .allEvents)
        doneIcon.addTarget(self, action: #selector(doneButtonClicked), forControlEvents: .touchUpInside)
        
        playlistsCellData?["PlaylistsCell"]?.addPlaylist()
    }
    
    @objc func editPlaylist(){
        doneIcon.image = UIImage(named: "checkMarkIconYellow")
        doneIcon.removeTarget(self, action: nil, forControlEvents: .allEvents)
        doneIcon.addTarget(self, action: #selector(doneButtonClickedEdit), forControlEvents: .touchUpInside)

        playlistsCellData?["PlaylistsCell"]?.addPlaylist()
    }
    
    @objc func doneButtonClicked(){
        currentlyCreatingPlaylist = false
        playlistEdit = false
        NotificationCenter.default.post(name: Notification.Name("playlistCreated"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("cancelClicked"), object: nil)
        didCreatePlaylist = false
        iconsSwitched = false
        isEditingNewPlaylist = false
    }
    
    @objc func doneButtonClickedEdit(){
        currentlyCreatingPlaylist = false
        playlistEdit = false
        didCreatePlaylist = false
        iconsSwitched = false
        isEditingNewPlaylist = false

        NotificationCenter.default.post(name: Notification.Name("playlistEdited"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("cancelClicked"), object: nil)
    }
}


     
