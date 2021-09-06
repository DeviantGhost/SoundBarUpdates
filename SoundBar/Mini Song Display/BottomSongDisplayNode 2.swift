//
//  BottomSongDisplayNode.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var globalAudioPlayer: AudioHandler?
var audioDurationGlobal: Double?

class BottomSongDisplay: BaseNode {
    
    let closeIcon = ASImageNode()
    let moreCircle = ASImageNode()
    let songPlayingDisplayBox = ASImageNode()
    let songImageDisplay = ASImageNode()
    let artistDisplayBox = ASTextNode()
    let songDisplayBox = ASTextNode()
    let playButton = ASButtonNode()
    let playPauseButton = ASButtonNode()
    let songProgressBar = ASImageNode()
    let songProgressBarCurrent = ASImageNode()
    var songPlaying = false
    var playButtonBool = Bool(true)
    var pauseButtonBool = Bool(false)
    
    var audioPlayer: AudioHandler!
    
    var songImage: String = ""
    var songName: String = ""
    
    var animationHandler: SongsAnimationHandler!
    var fullSongDataSource: [SongPresentation]!
    
    init(audio: AudioHandler, animationHandle: SongsAnimationHandler, data: [SongPresentation]) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setSongNameImage), name: NSNotification.Name("setSongNameAndImage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("switchFullSongData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displaySong), name: NSNotification.Name( "songDisplayer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playIcon), name: NSNotification.Name(rawValue: "playIcon"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseIcon), name: NSNotification.Name(rawValue: "pauseIcon"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchIconPreview), name: NSNotification.Name(rawValue: "switchIconPreview"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseButtonClicked), name: NSNotification.Name(rawValue: "resumeFullSong"), object: nil)
        
        audioPlayer = audio
        animationHandler = animationHandle
        fullSongDataSource = data
        animationHandler.setCurrentSongProgressBar(image: songProgressBarCurrent)
        animationHandler.setSongProgressBar(image: songProgressBar)
        
        setupNodes()
    }
    
    override func didEnterVisibleState() {
        isPlaying = true
        globalSongDisplayNode?.animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
    }
    
    @objc func updateData(_ notif: Notification) {
        if let data = notif.userInfo as? [String: [SongPresentation]] {
            fullSongDataSource = data["songs"]!
        }
    }
    
    override func didExitVisibleState() {
        fullSongOpen = false
    }
    
    @objc func setSongNameImage(_ notif: Notification) {
        let data = notif.userInfo as! [String: String]
        self.songName = data["name"]!
        self.songImage = data["image"]!
    }
    
    @objc func displaySong() {
        animationHandler.resumeSongProgressBar()
        animationHandler.animateSongProgressBar(progressBar: "current", duration: globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
        
        let currentNumber = findIndexNumber(song: fullSongNameGlobal)
        audioPlayer.setDatasourceSongNumber(number: currentNumber)
        
        songImageDisplay.image = UIImage(named: songImage)
        songDisplayBox.attributedText = NSAttributedString(string: songName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        songDisplayBox.style.preferredSize.height = songName.sizeOfString(font: UIFont.systemFont(ofSize: 15)).height
        songPlaying = true
        isPlaying = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: songDisplayBox)
        let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textCenter)
        
        let songImageDisplayPlayOverlay = ASOverlayLayoutSpec(child: songImageDisplay, overlay: playPauseButton)
        
        let closeIconStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 5,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [closeIcon])
        
        let closeIconSpec = ASStackLayoutSpec(direction: .horizontal,
                                          spacing: 0,
                                          justifyContent: .end,
                                          alignItems: .center,
                                          children: [closeIconStack])
        
        let closeIconInsetRight = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 25), child: closeIconSpec)
        
        let closeIconOverlayOnCell = ASOverlayLayoutSpec(child: songPlayingDisplayBox, overlay: closeIconInsetRight)
        
        let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 5,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [songImageDisplayPlayOverlay, textNodeInset])
        
        let fullLayout = ASOverlayLayoutSpec(child: closeIconOverlayOnCell, overlay: hCellStack)
    
        let songProgressBarOverlay = ASOverlayLayoutSpec(child: songProgressBar, overlay: songProgressBarCurrent)
        
        let progressBarStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .baselineFirst,
                                                 children: [songProgressBarOverlay, fullLayout])
        return progressBarStack
    }
    
    func setupNodes() {
        closeIcon.image = UIImage(named: "CancelSearchX")
        closeIcon.style.preferredSize = .init(width: 30, height: 30)
        closeIcon.contentMode = .scaleAspectFill
        closeIcon.addTarget(self, action: #selector(dismissBottomSongNode), forControlEvents: .touchUpInside)
        
        moreCircle.style.preferredSize = .init(width: 30, height: 30)
        moreCircle.cornerRadius = 30/2
        moreCircle.backgroundColor = UIColor(red: 0.125, green: 0.125, blue: 0.125, alpha: 1)
        
        songPlayingDisplayBox.backgroundColor = UIColor().topBackgroundGray()
        songPlayingDisplayBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: (bottomSongDisplayHeight - 3))
        songPlayingDisplayBox.addTarget(self, action: #selector(displayFullSongViewController), forControlEvents: .touchUpInside)

        songImageDisplay.image = UIImage(named: "")
        songImageDisplay.style.preferredSize = CGSize(width: (bottomSongDisplayHeight - 3), height: bottomSongDisplayHeight - 3)
        
        songDisplayBox.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        songDisplayBox.style.preferredSize = CGSize(width: 272, height: 80)
        
        songProgressBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        songProgressBar.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 3)
        
        songProgressBarCurrent.backgroundColor = UIColor().soundbarColorScheme()
        songProgressBarCurrent.style.preferredSize = CGSize(width: 0, height: 3)
        songProgressBarCurrent.anchorPoint = CGPoint(x: 0, y: 0)
        
        playPauseButton.setImage(UIImage(named: "PauseButtonDisplay"), for: .normal)
        playPauseButton.setImage(UIImage(named: "PlayButtonDisplay"), for: .selected)
        playPauseButton.style.preferredSize = CGSize(width: 20, height: 20)
        playPauseButton.alpha = 1
        playPauseButton.zPosition = 100
        playPauseButton.addTarget(self, action: #selector(pauseButtonClicked), forControlEvents: .touchUpInside)
    }
                                                        
    @objc func dismissBottomSongNode(){
        pauseButtonClicked()

        NotificationCenter.default.post(name: NSNotification.Name("resetSongBox"), object: nil)
    }
    
    @objc private func displayFullSongViewController() {
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        else {
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
        }
        
        let vc = FullSongPageViewController(audio: globalSongDisplayNode?.audioPlayer ?? AudioHandler())
        vc.modalPresentationStyle = .fullScreen
        self.closestViewController?.present(vc, animated: true, completion: nil)
    }

    func findIndexNumber(song: String) -> Int {
        for (index, item) in fullSongDataSource.enumerated() {
            if item.songName == song {
                return index
            }
        }
        return 0
    }
    
    @objc func pauseButtonClicked() {
        fullSongOpen = true
        if isPlayingSong {
            if previewAlreadyPlaying {
                NotificationCenter.default.post(name: Notification.Name("stopSongPreview"), object: nil)
                globalAudioPlayer?.setFullAudioLink(fullLink: fullSongLinkGlobal)
                globalAudioPlayer?.setCurrentTime(time: audioCurrentTime ?? CMTime())
                globalSongDisplayNode?.audioPlayer.playFullSong()
                pauseIcon()
                
                animationHandler.resumeSongProgressBar()
                previewAlreadyPlaying = false
            }
            else {
                let tempCurrentTime = CGFloat(audioCurrentTime?.value ?? 0)
                let tempDurationTime = CGFloat(globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds ?? 0)
                let progressRation = tempCurrentTime / tempDurationTime

                animationHandler.pauseSongProgressBar(size: CGSize(width: CGFloat(progressRation * UIScreen.main.bounds.width), height: 3))
                audioDurationGlobal = Double(tempDurationTime)
                globalSongDisplayNode?.audioPlayer.pauseFullSong()
                
                if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
                    audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
                }
                else{
                    audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)
                }
                playIcon()
            }
        }
        else {
            globalSongDisplayNode?.audioPlayer.togglePlay()
            if previewAlreadyPlaying{
                playPauseButton.isSelected = playButtonBool
            }
            else {
                animationHandler.resumeSongProgressBar()
                playPauseButton.isSelected = pauseButtonBool
            }
        }
    }

    @objc func playIcon(){
        playPauseButton.isSelected = playButtonBool
    }
    
    @objc func pauseIcon(){
        playPauseButton.isSelected = pauseButtonBool
    }
    
    @objc func switchIconPreview(){
        if isPlayingSong{
            playPauseButton.isSelected = playButtonBool
        }
        else{
            if previewAlreadyPlaying == false{
                playPauseButton.isSelected = playButtonBool
            }
            else{
                playPauseButton.isSelected = pauseButtonBool
            }
        }
    }
}



