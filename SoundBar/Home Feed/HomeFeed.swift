//
//  MainScreen.swift
//  TextureProject
//
//  Created by Danesh Rajasolan on 2020-07-31.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit
<<<<<<< Updated upstream

class HomeFeed: BaseNode, ASTableDelegate, ASTableDataSource {
    
    let tableNode = ASTableNode()
    var dataSource: HomeFeedDataModel?
    var spaceImage: CGFloat!
=======
import AVFoundation


class HomeFeed: BaseNode, ASTableDelegate, ASTableDataSource {
    
    var playerItem: AVPlayerItem!
    var audioPlayer: AudioHandler!
    var spaceImage: Double!
    
    let tableNode = ASTableNode()
    let homefeedViewModel = HomeFeedViewModel()
    var animationHandler: HomeAnimationHandler!
>>>>>>> Stashed changes
    
    init(space: Double!, audio: AudioHandler, animationHandle: HomeAnimationHandler) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(switchToPlaylistView), name: NSNotification.Name("switchToPlaylistView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToViewArtist), name: NSNotification.Name("switchToViewArtist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToSendFeed), name: NSNotification.Name("switchToSendFeed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hotBarsClicked), name: NSNotification.Name("hotBarsClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(followingFeedClicked), name: NSNotification.Name("followingFeedClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)

        tableNode.allowsSelection = false
        tableNode.dataSource = self
        tableNode.delegate = self
<<<<<<< Updated upstream
        tableNode.leadingScreensForBatching = 0
        spaceImage = space
        let data = Bundle.main.url(forResource: "songs", withExtension: "json")
        let modelsData = try! Data(contentsOf: data!)
        dataSource = try! JSONDecoder().decode(HomeFeedDataModel.self, from: modelsData)
    }
    
    var lastVelocityYSign = 0
=======
        tableNode.view.showsVerticalScrollIndicator = false
        tableNode.leadingScreensForBatching = 10
        tableNode.backgroundColor = .black
        tableNode.view.scrollsToTop = false
        tableNode.view.separatorStyle = .none
        audioPlayer = audio
        animationHandler = animationHandle
        
        homefeedViewModel.reloadTableView = { self.tableNode.reloadData() }
        homefeedViewModel.loadCellData(space: space, audio: audio)

        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        swipeLeftGesture.direction = .left
        swipeRightGesture.direction = .right
        
        tableNode.view.addGestureRecognizer(swipeLeftGesture)
        tableNode.view.addGestureRecognizer(swipeRightGesture)
    }
    
    override func didEnterVisibleState() {
        shareContentView = false
        fullSongOpen = false
        isPlayingSong = false
        
        audioPlayer.setSnippetAudioLink(snippetLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].snippetLink!)
        audioPlayer.setFullAudioLink(fullLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].fullLink!)
        audioPlayer.playClip()
    }
    
    @objc func switchToPlaylistView(){
        self.closestViewController?.present(AddToPlaylistViewController(), animated: true, completion: nil)
    }
    
    @objc func switchToSendFeed(){
        self.closestViewController?.present(SendFeedViewController(), animated: true, completion: nil)
    }
    
    @objc func switchToViewArtist(){
//        let vc = AccountProfileController(audio: audioPlayer, data: Prof)
//        vc.hidesBottomBarWhenPushed = true
//        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didExitVisibleState() {
        audioPlayer.stopAllAudio()
        shareContentView = true
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("hotBarsClicked"), object: nil)
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            print("node: swipe left")
            NotificationCenter.default.post(name: NSNotification.Name("swipeLeftToHotbars"), object: nil)
        case .right:
            print("node: swipe right")
            NotificationCenter.default.post(name: NSNotification.Name("swipeRightToFollowing"), object: nil)
        default:
            print("node: no swipe")
        }
    }
    
    var lastVelocityYSign = 0
    var path: IndexPath? = IndexPath(row: 0, section: 0)
    
>>>>>>> Stashed changes
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isPlayingSong = true
        
        if animationHandler.isPaused {
            animationHandler.continueRotatingDisk()
        }

        let currentVelocityY =  scrollView.panGestureRecognizer.velocity(in: scrollView.superview).y
        let currentVelocityYSign = Int(currentVelocityY).signum()
        if abs(currentVelocityY) > 1250 {//FIX
            lastVelocityYSign = currentVelocityYSign
            tableNode.view.isScrollEnabled = false
        }
        
        if currentVelocityYSign != lastVelocityYSign && currentVelocityYSign != 0 {
            
            lastVelocityYSign = currentVelocityYSign
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if path != nil {
            self.tableNode.scrollToRow(at: path!, at: .bottom, animated: true)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        tableNode.view.isScrollEnabled = true
        var indexPath: IndexPath? = path
        self.closestViewController?.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let tv = scrollView as? UITableView {
            let tempPath = tv.indexPathForRow(at: targetContentOffset.pointee)
            if lastVelocityYSign < 0 && tempPath?.row ?? path!.row <= path!.row {
                path = IndexPath(row: path!.row + 1, section: path!.section)
                self.tableNode.scrollToRow(at: path!, at: .bottom, animated: true)
                return
            } else if lastVelocityYSign > 0 && path!.row != 0 && tempPath?.row ?? path!.row >= path!.row {
                path = IndexPath(row: path!.row - 1, section: path!.section)
                self.tableNode.scrollToRow(at: path!, at: .bottom, animated: true)
                return
            }
            if tempPath != nil {
                path = tempPath
                if lastVelocityYSign < 0 {
<<<<<<< Updated upstream
                    var indexPath: IndexPath!
                    if path?.section == 0 {
                        indexPath = IndexPath(row: path!.row, section: 1)
                    } else {
                        indexPath = IndexPath(row: path!.row + 1, section: path!.section)
                    }
                    self.tableNode.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    
                 } else if lastVelocityYSign > 0 {
                    let indexPath = IndexPath(row: path!.row, section: path!.section)
                    self.tableNode.scrollToRow(at: indexPath, at: .bottom, animated: true)
                 }
=======
                    indexPath = IndexPath(row: path!.row + 1, section: path!.section)
                    self.tableNode.scrollToRow(at: indexPath!, at: .bottom, animated: true)
                } else if lastVelocityYSign > 0 {
                    indexPath = IndexPath(row: path!.row, section: path!.section)
                    self.tableNode.scrollToRow(at: indexPath!, at: .bottom, animated: true)
                }
>>>>>>> Stashed changes
            }
        }
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        audioPlayer.setCurrentSongNumber(number: path!.row)
        audioPlayer.setSnippetAudioLink(snippetLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].snippetLink!)
        audioPlayer.setFullAudioLink(fullLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].fullLink!)
        NotificationCenter.default.post(name: NSNotification.Name("notPaused"), object: nil)
        audioPlayer.unpauseCurrentSong()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
<<<<<<< Updated upstream
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        print("fetching new data")
//        if dataSource?.songsArtwork?.count < 15 {
//            DispatchQueue.main.async {
//                let indexRange = (self.data.count ..< self.data.count + 2)
//                let indexPaths = indexRange.map { IndexPath(row: $0, section: 1) }
//                indexRange.forEach { _ in
//                    self.data.append(CellData())
//                }
//                tableNode.insertRows(at: indexPaths, with: .none)
//                context.completeBatchFetching(true)
//            }
//        }
    }
    
=======
>>>>>>> Stashed changes
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return homefeedViewModel.numberOfSections
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
<<<<<<< Updated upstream
        return section == 0 ? 1 : (dataSource?.songsPresentation?.count ?? 0)
=======
        return homefeedViewModel.numberOfRows
>>>>>>> Stashed changes
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        print("node: \(indexPath.row)")
        return { [weak self] in
<<<<<<< Updated upstream
            if indexPath.section == 0 {
                
                let song = SongPresentation(fullLink: "", snippetLink: "", artist: "", songName: "", imageLink: "https://fsa.zobj.net/crop.php?r=grJtPW85OCT7n-gtZR-p7YBJogr6Ozg4M3IakzGaexTj6-aamsVuBpReuGHR2er29Tv3iDIkHBK9-0SYyXMUmuM9wFwRvxSs1qp1O3wZS47i1fTp1rRGCeLhkeHv32uYtTf0kIK4UoYaO1qFrufbrT1qW-uGalQ_CX7Uxd3BKa-IPblToUGgd4kagBA", comments:  "45k", likes: "135k", listens: "402k", songCaption: "Check out my latest hit single #viral #gonnamakeitbig", shares: "13k")
              
                if (self?.spaceImage.isEqual(to: 79))! {
                    return CellData(space: 15, song: song, backgroundImageSpace: self!.spaceImage + 45)
                } else {
                    return CellData(space: 15, song: song, backgroundImageSpace: self!.spaceImage + 5)
               
                }
            } else {
                let song = self?.dataSource?.songsPresentation?[indexPath.row]
                if (self?.spaceImage.isEqual(to: 79))! {
                    return CellData(song: song, backgroundImageSpace: self!.spaceImage)
                } else {
                    return CellData(space: 25, song: song, backgroundImageSpace: self!.spaceImage)
=======
            return self!.homefeedViewModel.getCellAt(row: indexPath.row, animationHandler: self!.animationHandler)
        }
    }
    
    @objc private func hotBarsClicked(_ notification: Notification?) {
        homefeedViewModel.switchDataSources()
        fullSongOpen = false
        
        audioPlayer.setSnippetAudioLink(snippetLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].snippetLink!)
        audioPlayer.setFullAudioLink(fullLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].fullLink!)
        audioPlayer.unpauseCurrentSong()
    }
    
    @objc private func followingFeedClicked(_ notification: Notification?) {
        homefeedViewModel.switchDataSources()
        fullSongOpen = false
        
        audioPlayer.setSnippetAudioLink(snippetLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].snippetLink!)
        audioPlayer.setFullAudioLink(fullLink: homefeedViewModel.homefeedData[audioPlayer.getSongNumber].fullLink!)
        audioPlayer.unpauseCurrentSong()
    }
    
    @objc func didFinishPlaying(notification: Notification) {
        let stoppedPlayerItem: AVPlayerItem = notification.object as! AVPlayerItem
        stoppedPlayerItem.seek(to: CMTime.zero) { (result) in
            if result {
                if fullSongOpen {
                    print("Successfully restarted song.")
                    self.audioPlayer.restart()
                    self.audioPlayer.playFullSong()
                    isPlayingSong = true
                } else {
                    if self.audioPlayer.getSongNumber < self.homefeedViewModel.numberOfRows {
                        self.path = IndexPath(row: self.path!.row+1, section: 0)
                        self.audioPlayer.setCurrentSongNumber(number: self.path!.row)
                        self.tableNode.scrollToRow(at: self.path!, at: .bottom, animated: true)
                        self.audioPlayer.setSnippetAudioLink(snippetLink: self.homefeedViewModel.homefeedData[self.audioPlayer.getSongNumber].snippetLink!)
                        self.audioPlayer.setFullAudioLink(fullLink: self.homefeedViewModel.homefeedData[self.audioPlayer.getSongNumber].fullLink!)
                        
                        self.audioPlayer.playClip()
                    }
>>>>>>> Stashed changes
                }
            }
        }
    }
    
    deinit {
        print("node: get run here")
    }
}
