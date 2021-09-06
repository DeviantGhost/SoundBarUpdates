//
//  PlaylistPage.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-03.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit


class PlaylistPage: BaseNode, ASTableDelegate, ASTableDataSource {
    
    let tableNode = ASTableNode()
    var playlistSongs: [SongPresentation]!

    var topControls: TopControls!
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    init(audio: AudioHandler, animationHandle: SongsAnimationHandler, data: [SongPresentation]) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreated), name: NSNotification.Name(rawValue: "playlistCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreated), name: NSNotification.Name(rawValue: "playlistEdited"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(doneClicked), name: NSNotification.Name(rawValue: "cancelClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editPlaylist), name: NSNotification.Name("editPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPlaylist), name: NSNotification.Name("deletePlaylist"), object: nil)
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = .clear
        tableNode.view.separatorStyle = .none
        
        audioPlayer = audio
        playlistSongs = data
        animationHandler = animationHandle

        topControls = TopControls()
        topControls.frame = CGRect(x: 0, y: (globalScreenTopPadding * 1.5) + 25, width: UIScreen.main.bounds.width, height: 30)
        topControls.backgroundColor = .clear
        view.addSubnode(topControls)
    }
    
    @objc func doneClicked(){
        topControls.removeFromSupernode()

        topControls = TopControls()
        topControls.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 50)
        topControls.backgroundColor = .clear
        view.addSubnode(topControls)
    }
    
    override func didEnterVisibleState() {
        playlistOpened = true
    }
    
    override func didExitVisibleState() {
        playlistOpened = false
        
        if playlistEdit == false {
            songsCellData = [SongPresentation]()
            playlistNameGlobal = ""
            songsCellData = []
            songsCellArray = []
            songCellCurrent = []
        }
        
        playlistEdit = false
        
        if currentlyCreatingPlaylist == true {
            NotificationCenter.default.post(name: NSNotification.Name("addSongToPlaylist"), object: nil)
        }
    }
    
    @objc func editPlaylist(){
        self.tableNode.reloadData()
    }
    
    @objc func playlistCreated(){
        let path = IndexPath(row: 0, section: 0)
        self.tableNode.reloadRows(at: [path], with: .fade)
    }
    
    @objc func dismissPlaylist() {
        self.closestViewController?.navigationController?.popViewController(animated: true)

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        print("fetching new data")
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            if indexPath.section == 0 {
                return TopDisplay(songs: self!.playlistSongs, audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                
            } else {
                return PlaylistCell(title: "SongList", songs: songsCellData, audio: self!.audioPlayer, animationHandle: self!.animationHandler)
            }
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("item clicked...\n hereee")
    }
}


    
