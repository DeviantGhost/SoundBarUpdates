//
//  FollowFeed.swift
//  SoundBar
//
//  Created by Justin Cose on 7/21/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class FollowFeed: BaseNode, ASTableDelegate, ASTableDataSource {

    var playerItem: AVPlayerItem!
    let tableNode = ASTableNode()
    
    var profileInfo: ProfileInfo!
    var followButtons: FollowButtons!
    var followSearchBar: FollowSearchBar!
    var followTop: FollowTop!
    
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    
    var followBackButton = ASImageNode()
    
    var data: ProfileHeader!
    var isArtist: Bool!
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearSearchBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistClicked), name: Notification.Name("playlistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(artistClicked), name: Notification.Name("artistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesClicked), name: Notification.Name("favoritesClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentSongList), name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
        tableNode.backgroundColor = UIColor.clear
        tableNode.reloadData()
        
        self.backgroundColor = UIColor().topBackgroundGray()
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
    }
    
    @objc func playlistClicked() {
        if currentTab == "Reposts" { } else {
            currentTab = "Reposts"
            let indexPath = IndexPath(item: 0, section: 0)
            tableNode.reloadRows(at: [indexPath], with: .right)
        }
    }
    
    @objc func artistClicked() {
        let indexPath = IndexPath(item: 0, section: 0)
        
        if currentTab == "Reposts" {
            currentTab = "Artists"
            tableNode.reloadRows(at: [indexPath], with: .left)
        } else if currentTab == "Artists" { } else {
            currentTab = "Artists"
            tableNode.reloadRows(at: [indexPath], with: .right)
        }
    }
    
    @objc func favoritesClicked() {
        if currentTab == "Favorites" { } else {
            currentTab = "Favorites"
            let indexPath = IndexPath(item: 0, section: 0)
            tableNode.reloadRows(at: [indexPath], with: .left)
        }
    }
    
    @objc func clearSearchBar() {
        DispatchQueue.main.async {
            self.followSearchBar.searchText.resignFirstResponder()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            self.followSearchBar.searchText.resignFirstResponder()
        }
    }

    override func didEnterVisibleState() {
        followTop = FollowTop()
        followTop.frame = CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: 80)
        followTop.zPosition = 15
        view.addSubnode(followTop)
        
        followButtons = FollowButtons()
        followButtons.frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 40)
        followButtons.zPosition = 10
        view.addSubnode(followButtons)
        
        followSearchBar = FollowSearchBar()
        followSearchBar.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 20)) / 2), y: 130, width: UIScreen.main.bounds.width - 20, height: 35)
        followSearchBar.zPosition = 10
        view.addSubnode(followSearchBar)
        
        isPlaying = false
        fullSongOpen = true
    }
    
    override func didExitDisplayState() {
        lastClickedButton?.image = UIImage(named: "PlayPlaylistButton")
        lastClickedButton = nil
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 175, left: 0, bottom: 0, right: 0), child: tableNode)
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
            return FollowPageCells()
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("item clicked...\n hereee")
    }

    var continuePlayingDatasource: [SongPresentation]? = nil
    @objc func updateCurrentSongList(_ notif: Notification) {
        if let data = notif.userInfo as? [String: [SongPresentation]] {
            continuePlayingDatasource = data["songs"]!
            audioPlayer.setDataSource(data: data["songs"]!)
        }
    }
    
    @objc func didFinishPlaying(notification: Notification) {
        let stoppedPlayerItem: AVPlayerItem = notification.object as! AVPlayerItem
        stoppedPlayerItem.seek(to: CMTime.zero) { (result) in
            if result {
                if fullSongOpen {
                    print("Successfully moved to next song.")
                    NotificationCenter.default.post(name: NSNotification.Name("moveToNextSong"), object: nil)
                    isPlaying = true
                    self.animationHandler.animateSongProgressBar(progressBar: "current", duration: self.audioPlayer.getFullPlayerItem.asset.duration.seconds)
                } else {
                    self.audioPlayer.restart()
                    self.audioPlayer.unpauseCurrentSong()
                    self.animationHandler.animateSongProgressBar(progressBar: "current", duration: (self.audioPlayer.getSnippetPlayer.currentItem?.asset.duration.seconds)!)
                }
            }
        }
    }
}
