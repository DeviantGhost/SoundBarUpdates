//
//  LibraryFeed.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-03-21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var currentTab = "Playlists"
var lastTab = "Playlists"
var bottomSongDisplayLoaded = false

class LibraryFeed: BaseNode {

    var playerItem: AVPlayerItem!
    let tableNode = ASTableNode()

    var libraryNodes: (libraryTop: LibrarySearchTop?, libraryTabBar: LibraryButtons?)
    var playlistControls = PlaylistControls()
    
    var collectionNodePosition = CGFloat(0)
    var recentSearchesText = ASTextNode()
    
    var songDisplayNode: BottomSongDisplay!
    
    var audioPlayer: AudioHandler!
    let animationHandler = SongsAnimationHandler()
    let profileFeedViewModel = LibraryFeedViewModel()
    var data: ProfileHeader!

    init(audio: AudioHandler, data: ProfileHeader, libraryTop: LibrarySearchTop, libraryTabBar: LibraryButtons) {
        super.init()
        audioPlayer = audio
        self.backgroundColor = UIColor().topBackgroundGray()
        self.data = data
        self.libraryNodes.libraryTop = libraryTop
        self.libraryNodes.libraryTabBar = libraryTabBar
        
        profileFeedViewModel.reloadTableView = {
            self.tableNode.reloadData()
        }
        
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.zPosition = 2
        tableNode.backgroundColor = UIColor.clear
        tableNode.view.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        tableNode.view.isScrollEnabled = false

        setUpNodes()
        setUpNotificationCenter()
    }
    
    func setUpNodes(){
        self.libraryNodes.libraryTabBar?.zPosition = 4

        self.libraryNodes.libraryTop?.backgroundColor = UIColor().topBackgroundGray()
        self.libraryNodes.libraryTop?.zPosition = 10
    }
    
    @objc func messageArtistShare(){
        let vc = MessageCellViewController()
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("createNewPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreated), name: NSNotification.Name("playlistCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(newPlaylistEdited), name: NSNotification.Name("playlistEdited"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissPlaylist), name: NSNotification.Name("deletePlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissNewPlaylist), name: NSNotification.Name("cancelClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissNewPlaylist), name: NSNotification.Name("dismissNewPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreate), name: NSNotification.Name("playlistCreate"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistOpen), name: NSNotification.Name("playlistOpen"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(messageArtistShare), name: NSNotification.Name("messageArtistShare"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSetupData), name: NSNotification.Name("didSetupData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(activateSearchBar), name: NSNotification.Name("activateSearchBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearSearchBar), name: NSNotification.Name("clearLibrarySearchBar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: NSNotification.Name("closeKeyboard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistEditClicked), name: NSNotification.Name("editPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistClicked), name: Notification.Name("playlistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(artistClicked), name: Notification.Name("artistClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesClicked), name: Notification.Name("favoritesClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentSongList), name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(songClicked), name: NSNotification.Name(rawValue: "songDisplayAnimation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(songDismissed), name: NSNotification.Name(rawValue: "resetSongBox"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    @objc func newPlaylistEdited(){
        profileFeedViewModel.reloadEditDatasourcePlaylist()
    
    }
    
    @objc func dismissPlaylist() {
        self.closestViewController?.navigationController?.popViewController(animated: true)

    }
    
    @objc func playlistOpen(){
        self.closestViewController?.navigationController?.pushViewController(PlaylistPageViewController(audio: globalAudioPlayer ?? audioPlayer, playlistSongs: songsCellData, animationHandle: animationHandler), animated: true)
    }
    
    override func didLoad() {
        tableNode.view.showsVerticalScrollIndicator = false
        profileFeedViewModel.loadCellData(animationHandle: animationHandler, audio: audioPlayer, profile: data)
        tableNode.view.isScrollEnabled = false
    }
    
    @objc func songClicked(){
        if songBoxDisplaying == false {
            if currentlyCreatingPlaylist == true {
                playlistControls.displayBoxPopsUp()
                playlistControls.position.y -= bottomSongDisplayHeight - 2
                
            }
            
            bottomSongDisplayLoaded = true
            globalSongDisplayNode?.displayBoxPopsUp()
            globalSongDisplayNode?.position.y -= bottomSongDisplayHeight - 2
            songBoxDisplaying = true
        }
    }
    
    @objc func songDismissed(){
        if songBoxDisplaying == true {
            if currentlyCreatingPlaylist == true {
                playlistControls.displayBoxPopsDown()
                playlistControls.position.y += bottomSongDisplayHeight - 2
            }
            
            globalSongDisplayNode?.displayBoxPopsDown()
            globalSongDisplayNode?.position.y += bottomSongDisplayHeight - 2
            songBoxDisplaying = false
        }
    }
    
    @objc func switchToViewArtist(){
//        if artistProfile == false {
//            artistProfile = true
//            self.closestViewController?.navigationController?.pushViewController(AccountProfileController(audio: audioPlayer, data: <#ProfileHeader#>), animated: true)
//        }
    }
    
    override func didExitVisibleState() {
        if currentlyCreatingPlaylist == false {
            playlistControls.removeFromSupernode()
        }
    }
    
    
    @objc func playlistClicked() {
        currentTab = lastTab
        if currentTab != "Playlists" {
            currentTab = "Playlists"
            lastTab = "Playlists"
            let collectionNode = IndexPath(item: 0, section: 2)
            self.tableNode.reloadRows(at: [collectionNode], with: .right)
   
        }
    }
    
    @objc func artistClicked() {
        currentTab = lastTab

        let collectionNode = IndexPath(item: 0, section: 2)

        if currentTab == "Playlists" {
            tableNode.view.isScrollEnabled = false

            currentTab = "Artists"
            lastTab = "Artists"
 
            self.tableNode.reloadRows(at: [collectionNode], with: .left)
        }
        else if currentTab != "Artists" {
            tableNode.view.isScrollEnabled = false

            currentTab = "Artists"
            lastTab = "Artists"

            self.tableNode.reloadRows(at: [collectionNode], with: .right)


        }
    }
    
    @objc func favoritesClicked() {
        currentTab = lastTab
        tableNode.view.isScrollEnabled = false

        if currentTab != "Favorites" {
            currentTab = "Favorites"
            lastTab = "Favorites"
            
            let collectionNode = IndexPath(item: 0, section: 2)
            self.tableNode.reloadRows(at: [collectionNode], with: .left)
        }
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: self.tableNode)
    }
    
    @objc func closeKeyboard(){
        DispatchQueue.main.async {
            self.libraryNodes.libraryTop?.searchText.resignFirstResponder()
        }
    }
    
    @objc func activateSearchBar() {
        tableNode.view.isScrollEnabled = true
        
        currentTab = lastTab
        
        DispatchQueue.main.async {
            self.libraryNodes.libraryTop?.searchText.becomeFirstResponder()
        }
        
        lastTab = currentTab
        currentTab = "History"

        let indexPath = IndexPath(item: 0, section: 1)
        let indexPath2 = IndexPath(item: 0, section: 2)
        
        tableNode.reloadRows(at: [indexPath], with: .fade)
        tableNode.reloadRows(at: [indexPath2], with: .fade)
    
        recentSearchesText.alpha = 1
    }
   
    @objc func clearSearchBar() {
        
        
        recentSearchesText.alpha = 0
        currentTab = lastTab
        
        let indexPath = IndexPath(item: 0, section: 1)
        let indexPath2 = IndexPath(item: 0, section: 2)
        
        tableNode.reloadRows(at: [indexPath], with: .fade)
        tableNode.reloadRows(at: [indexPath2], with: .fade)
        
        self.libraryNodes.libraryTop?.scrollClearSearchBar()
        
        DispatchQueue.main.async {
            self.libraryNodes.libraryTop?.searchText.resignFirstResponder()
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentTab == "History" {
            if (scrollView.contentOffset.y < 0) {
                clearSearchBar()
                
                searchOpen = false
            }
            DispatchQueue.main.async {
                self.closeKeyboard()
            }
        }
    }
    
    @objc func dismissNewPlaylist() {
        self.libraryNodes.libraryTop?.isUserInteractionEnabled = true
        self.libraryNodes.libraryTabBar?.isUserInteractionEnabled = true
        self.libraryNodes.libraryTop?.isUserInteractionEnabled = true
        tableNode.isUserInteractionEnabled = true
        
        globalSongDisplayNode?.alpha = 1
        
        playlistControls.alpha = 0
        playlistControls.removeFromSupernode()
    }
    
    @objc func playlistCreate(){
        if playlistEdit == false {
            playlistEdit = true

            audioPlayer = AudioHandler()

            self.closestViewController?.navigationController?.pushViewController(PlaylistPageViewController(audio: audioPlayer, playlistSongs: songsCellData, animationHandle: animationHandler), animated: true)
        }
    }
    
    @objc func createNewPlaylist() {
        playlistControls.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - tabBarHeight - 70, width: UIScreen.main.bounds.width, height: 50)
        
        if songBoxDisplaying == true {
            playlistControls.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - tabBarHeight - bottomSongDisplayHeight - 70, width: UIScreen.main.bounds.width, height: 50)
        }
        
        playlistControls.zPosition = 15
        playlistControls.alpha = 1
        view.addSubnode(playlistControls)
        
        globalSongDisplayNode?.alpha = 1
    }
    
    @objc func playlistCreated() {
        profileFeedViewModel.reloadDatasourcePlaylist()
    }
    
    @objc func playlistEditClicked(){
        playlistEdit = true
        playlistControls.alpha = 1
    }
    
    @objc func didSetupData(){
        let indexPath = IndexPath(item: 0, section: 2)
        let rectOfCellInTableView = tableNode.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableNode.convert(rectOfCellInTableView, to: tableNode.supernode)
        
        collectionNodePosition = rectOfCellInSuperview.origin.y
        NotificationCenter.default.post(name: NSNotification.Name("setCollectionNodeHeight"), object: nil, userInfo: ["collectionNodeHeight" : rectOfCellInSuperview.origin.y] )
    }

    override func layoutDidFinish() {
        let indexPath = IndexPath(item: 0, section: 2)
        let rectOfCellInTableView = tableNode.rectForRow(at: indexPath)
        let rectOfCellInSuperview = tableNode.convert(rectOfCellInTableView, to: tableNode.supernode)
        
        collectionNodePosition = rectOfCellInSuperview.origin.y
    }
    
    override func didEnterVisibleState() {
        if currentlyCreatingPlaylist == true {
            playlistControls.zPosition = 15
            playlistControls.alpha = 1
            view.addSubnode(playlistControls)
        }
    
        isPlaying = false
        fullSongOpen = true
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

extension LibraryFeed: ASTableDelegate, ASTableDataSource {
    
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
        return profileFeedViewModel.numberOfSections
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return profileFeedViewModel.numberOfRows
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            (self?.profileFeedViewModel.getSectionAt(section: indexPath.section, libraryPage: self!.libraryNodes, collectionPosition: self!.collectionNodePosition))!
        }
    }
}
