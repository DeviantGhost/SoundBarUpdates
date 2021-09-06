//
//  MessageMediaFeed.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class MessageMediaFeed: BaseNode, ASTableDelegate, ASTableDataSource {

    let tableNode = ASTableNode()
    
    var followTop: MessageMediaTop!
    var messageMediaSearch: MessageMediaSearch!
    var topBackground = ASImageNode()
    
    var playerItem: AVPlayerItem!
    
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    let profileHomeViewModel = ProfileHomeViewModel()
    
    var data: ProfileHeader!

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearSearchBar"), object: nil)
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
  
        self.backgroundColor = UIColor().backgroundGray()
        tableNode.backgroundColor = UIColor.clear
        
        profileHomeViewModel.reloadTableView = {
            self.tableNode.reloadData()
        }
        
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
       // profileHomeViewModel.loadCellData(animationHandle: animationHandler, audio: audioPlayer, isArt: isArtist, profile: data)
    }
    
    @objc func clearSearchBar() {
        DispatchQueue.main.async {
            self.messageMediaSearch.searchText.resignFirstResponder()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            self.messageMediaSearch.searchText.resignFirstResponder()
        }
    }
    
    override func didEnterVisibleState() {
        topBackground.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80)
        topBackground.zPosition = 5
        topBackground.backgroundColor = UIColor().topBackgroundGray()
        view.addSubnode(topBackground)
        
        followTop = MessageMediaTop()
        followTop.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 60)
        followTop.zPosition = 15
        view.addSubnode(followTop)
        
        messageMediaSearch = MessageMediaSearch()
        messageMediaSearch.frame = CGRect(x: (((UIScreen.main.bounds.width)-(UIScreen.main.bounds.width - 20)) / 2), y: 100, width: UIScreen.main.bounds.width - 20, height: 35)
        messageMediaSearch.zPosition = 10
        view.addSubnode(messageMediaSearch)
    }
    
    override func didExitDisplayState() {
   
  
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        return ASInsetLayoutSpec(insets: .init(top: 145, left: 0, bottom: 0, right: 0), child: tableNode)
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
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            return ASCellNode()
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


