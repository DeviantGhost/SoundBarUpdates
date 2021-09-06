//
//  ProfileFeedHome.swift
//  SoundBar
//
//  Created by Justin Cose on 7/8/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import AsyncDisplayKit

var currentTabHome = "Reposts"

class ProfileFeedHome: BaseNode {

    var playerItem: AVPlayerItem!
    let tableNode = ASTableNode()

    var profileNodes: (profileHomeTop: ProfileInfo?, profileHomeTabBar: ProfileFeedButtons?)
    var accountTopControls: AccountTopControls!
    var songDisplayNode: BottomSongDisplay!
    var audioPlayer: AudioHandler!
    
    let animationHandler = SongsAnimationHandler()
    let profileHomeViewModel = ProfileHomeViewModel()
    
    var data: ProfileHeader!
    var isArtist: Bool!
    
    init(audio: AudioHandler, data: ProfileHeader, isArt: Bool, profileTop: ProfileInfo, profileTabBar: ProfileFeedButtons) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(playlistClicked), name: Notification.Name("playlistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(artistClicked), name: Notification.Name("artistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentSongList), name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        audioPlayer = audio
        isArtist = isArt
        self.data = data
        
        self.profileNodes.profileHomeTop = profileTop
        self.profileNodes.profileHomeTabBar = profileTabBar

        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
        tableNode.backgroundColor = UIColor.clear
        
        self.backgroundColor = UIColor(red: 0.035, green: 0.035, blue: 0.035, alpha: 1)
        
        profileHomeViewModel.reloadTableView = {
            self.tableNode.reloadData()
        }
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
        profileHomeViewModel.loadCellData(animationHandle: animationHandler, audio: audioPlayer, isArt: isArtist, profile: data)
    }
    
    @objc func playlistClicked() {
        if currentTab == "Reposts" { } else {
            currentTab = "Reposts"
            let indexPath = IndexPath(item: 0, section: 2)
            tableNode.reloadRows(at: [indexPath], with: .right)
        }
    }

    @objc func artistClicked() {
        let indexPath = IndexPath(item: 0, section: 2)
        if currentTabHome == "Reposts" {
            currentTabHome = "Tracks"
            tableNode.reloadRows(at: [indexPath], with: .left)
        }
        else if currentTabHome == "Tracks" { } else {
            currentTab = "Artists"
            tableNode.reloadRows(at: [indexPath], with: .right)
        }
    }

    @objc func favoritesClicked() {
        if currentTabHome == "Favorites" { } else {
            currentTabHome = "Favorites"
            let indexPath = IndexPath(item: 0, section: 2)
            tableNode.reloadRows(at: [indexPath], with: .left)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.tableNode)
    }

    override func didEnterVisibleState() {
        accountTopControls = AccountTopControls()
        accountTopControls.frame = CGRect(x: 0, y: (globalScreenTopPadding * 1.5) + 25, width: UIScreen.main.bounds.width, height: 30)
        accountTopControls.backgroundColor = .clear
        accountTopControls.zPosition = 100
        view.addSubnode(accountTopControls)
        
        isPlaying = false
        fullSongOpen = true
        audioPlayer.pauseCurrentSong()
    }
    
    override func didExitDisplayState() {
        lastClickedButton?.image = UIImage(named: "PlayPlaylistButton")
        lastClickedButton = nil
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

extension ProfileFeedHome: ASTableDelegate, ASTableDataSource {
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
        return profileHomeViewModel.numberOfSections
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return profileHomeViewModel.numberOfRows
    }
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in (
            self?.profileHomeViewModel.getSectionAt(section: indexPath.section, profilePage: self!.profileNodes)
            )!
        }
    }
}
