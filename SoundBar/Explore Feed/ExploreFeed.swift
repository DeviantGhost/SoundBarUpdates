//
//  ExploreFeed.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-09-03.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var displayingSongTab = false
var exploreHistory = false
var exploreSections = 7

class ExploreFeed: BaseNode, ASTableDelegate, ASTableDataSource {

    var playerItem: AVPlayerItem!
    let tableNode = ASTableNode()
<<<<<<< Updated upstream

    override init() {
=======
    var searchBar: ExploreSearch!
    var songDisplayNode: BottomSongDisplay!

    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    let exploreViewModel = ExploreFeedViewModel()

    var reloadTableView: (()->())?
  
    init(audio: AudioHandler) {
>>>>>>> Stashed changes
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearSearchBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(exploreTrendingOpen), name: NSNotification.Name("activateExploreBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchBottomSongData), name: NSNotification.Name(rawValue: "switchBottomSongDisplayData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentSongList), name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(searchTableView), name: NSNotification.Name("searchTableView"), object: nil)

        audioPlayer = audio
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
<<<<<<< Updated upstream
        tableNode.view.backgroundColor = .black
        tableNode.backgroundColor = .black
//        tableNode.view.separatorColor = .white
        setupDatasource()
    }
    
=======
        tableNode.backgroundColor = UIColor().backgroundGray()
        tableNode.zPosition = 2
 
        exploreViewModel.reloadTableView = { self.tableNode.reloadData() }
        exploreViewModel.loadCellData(animationHandle: animationHandler, audio: audioPlayer)
    }

    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
    }

    @objc func switchBottomSongData(_ notif: Notification) {
        if let data = notif.userInfo as? [String: Any] {
            exploreViewModel.switchBottomSongData(cellType: data["data"] as! String)
        }
    }

    @objc func clearSearchBar() {
        exploreSections = 7

        DispatchQueue.main.async {
            self.searchBar.searchText.resignFirstResponder()
        }

        exploreHistory = false

        let indexPath = IndexPath(item: 0, section: 0)
        let indexPath1 = IndexPath(item: 0, section: 1)
        let indexPath2 = IndexPath(item: 0, section: 2)
        let indexPath3 = IndexPath(item: 0, section: 3)
        let indexPath4 = IndexPath(item: 0, section: 4)
        let indexPath5 = IndexPath(item: 0, section: 5)
        let indexPath6 = IndexPath(item: 0, section: 6)

        tableNode.reloadRows(at: [indexPath], with: .fade)
        tableNode.reloadRows(at: [indexPath1], with: .fade)
        tableNode.reloadRows(at: [indexPath2], with: .fade)
        tableNode.reloadRows(at: [indexPath3], with: .fade)
        tableNode.reloadRows(at: [indexPath4], with: .fade)
        tableNode.reloadRows(at: [indexPath5], with: .fade)
        tableNode.reloadRows(at: [indexPath6], with: .fade)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if exploreHistory == true {
            if (scrollView.contentOffset.y < 0) {
                clearSearchBar()
                self.searchBar.clearSearchBar()
            }
            DispatchQueue.main.async {
                self.searchBar.searchText.resignFirstResponder()
            }
        }
    }

    @objc func exploreTrendingOpen() {
        exploreHistory = true
        
        let indexPath = IndexPath(item: 0, section: 0)
        let indexPath1 = IndexPath(item: 0, section: 1)
        let indexPath2 = IndexPath(item: 0, section: 2)
        let indexPath3 = IndexPath(item: 0, section: 3)
        let indexPath4 = IndexPath(item: 0, section: 4)
        let indexPath5 = IndexPath(item: 0, section: 5)
        let indexPath6 = IndexPath(item: 0, section: 6)

        tableNode.reloadRows(at: [indexPath], with: .fade)
        tableNode.reloadRows(at: [indexPath1], with: .fade)
        tableNode.reloadRows(at: [indexPath2], with: .fade)
        tableNode.reloadRows(at: [indexPath3], with: .fade)
        tableNode.reloadRows(at: [indexPath4], with: .fade)
        tableNode.reloadRows(at: [indexPath5], with: .fade)
        tableNode.reloadRows(at: [indexPath6], with: .fade)
    }

    override func didEnterVisibleState() {
        fullSongOpen = false
        isPlaying = false
        audioPlayer.pauseCurrentSong()

        searchBar = ExploreSearch()
        searchBar.frame = CGRect(x: (-(UIScreen.main.bounds.width - 20) / 2) + 10, y: globalTopScreenPadding, width: UIScreen.main.bounds.width - 20, height: 45)
        searchBar.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        searchBar.zPosition = 10
        view.addSubnode(searchBar)
    }

    override func didExitVisibleState() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("switchBottomSongDisplayData"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("resetSongBox"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("dismissFullSongDisplayAnimation"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("songDisplayAnimation"), object: nil)
    }

>>>>>>> Stashed changes
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 55 + globalTopScreenPadding, left: 0, bottom: 0, right: 0), child: tableNode)
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
            return 7
    }

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
            return 1
    }

    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
<<<<<<< Updated upstream
            if indexPath.section == 0 {
                return ExploreSearch()
            } else if indexPath.section == 1 {
                return ExplorePlaylistCell(type: "AD")
            } else if indexPath.section == 2 {
                return ExplorePlaylistCell(type: "Header")
            } else if indexPath.section == 3 {
                return ExplorePlaylistCell(type: "Trending")
            } else if indexPath.section == 4 {
                return PlaylistCell(title: "Recommended", playlists: ProfileMusic(userTracks: nil, userPlaylists: UserPlaylists(playlists: nil, favorites: [UserTracks(imageLink: "https://static.billboard.com/files/media/dababy-South-Coast-Music-Group-2019-billboard-1548-1024x677.jpg", songName: "Billion Dollar Baby", listenCount: "7M"), UserTracks(imageLink: "https://static.billboard.com/files/media/dababy-South-Coast-Music-Group-2019-billboard-1548-1024x677.jpg", songName: "Billion Dollar Baby", listenCount: "7M"), UserTracks(imageLink: "https://static.billboard.com/files/media/dababy-South-Coast-Music-Group-2019-billboard-1548-1024x677.jpg", songName: "Billion Dollar Baby", listenCount: "7M"), UserTracks(imageLink: "https://static.billboard.com/files/media/dababy-South-Coast-Music-Group-2019-billboard-1548-1024x677.jpg", songName: "Billion Dollar Baby", listenCount: "7M"), UserTracks(imageLink: "https://static.billboard.com/files/media/dababy-South-Coast-Music-Group-2019-billboard-1548-1024x677.jpg", songName: "Billion Dollar Baby", listenCount: "7M")])), isArt: false)
            } else {
                return ExplorePlaylistCell(type: "Suggested")
            }
        }
    }
    
    private func setupDatasource() {
=======
            guard self != nil else { return ASCellNode() }
            return self!.exploreViewModel.getCellAt(cell: indexPath)
        }
    }

    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        print("item clicked...\n hereee")
    }

    var continuePlayingDatasource: [SongPresentation]? = nil

    @objc func updateCurrentSongList(_ notif: Notification) {
        if let data = notif.userInfo as? [String: [SongPresentation]] {
            print(data["songs"]!)
            continuePlayingDatasource = data["songs"]!
            audioPlayer.setDataSource(data: data["songs"]!)
        }
    }

    @objc func searchTableView(){
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
    }

    @objc func didFinishPlaying(notification: Notification) {
        let stoppedPlayerItem: AVPlayerItem = notification.object as! AVPlayerItem
        stoppedPlayerItem.seek(to: CMTime.zero) { (result) in
            if result {
                if fullSongOpen {
                    NotificationCenter.default.post(name: NSNotification.Name("moveToNextSong"), object: nil)
                    isPlaying = true
                    self.animationHandler.animateSongProgressBar(progressBar: "current", duration: self.audioPlayer.getFullPlayerItem.asset.duration.seconds)
                }
                else {
                    self.audioPlayer.restart()
                    self.audioPlayer.unpauseCurrentSong()
                    self.animationHandler.animateSongProgressBar(progressBar: "current", duration: (self.audioPlayer.getSnippetPlayer.currentItem?.asset.duration.seconds)!)
                }
            }
        }
>>>>>>> Stashed changes
    }
    
}
