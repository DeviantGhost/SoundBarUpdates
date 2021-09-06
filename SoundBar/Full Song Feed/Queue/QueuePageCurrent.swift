//
//  BottomSongDisplayNode.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit


class QueuePageCurrent: BaseCellNode {
    
//    let moreButton = ASButtonNode()
//    let songCurrentBackgroundBox = ASImageNode()
//
//    var songPlaying = false
//
//    let songNameBox = ASTextNode()
//    let artistNameBox = ASTextNode()
    
    
    let playingFrom = ASTextNode()
    let albumName = ASTextNode()
    
    let headphonesImageHighlighted = ASImageNode()
    
    var bottomPadding = ASImageNode()
    
    let loopButton = ASImageNode()
    let shuffleButton = ASImageNode()
    
    var song: [SongPresentation]!
    
    var songCircle = ASImageNode()
    
    let playlistImage = ASImageNode()
    
    var loopButtonSelected = false
    var shuffleButtonSelected = false
    //let textNode = ASTextNode()
    
    let backgroundImageNode = ASImageNode()
    let moreButtonNode = ASButtonNode()
    
    //let listensNode = ASButtonNode()
    
    let playButton = ASImageNode()
    
    let nameTextNode = ASTextNode()
    let songTextNode = ASTextNode()
    
    var audioPlayer: AudioHandler!
    
    var songName: String = ""
    var songArtist: String = ""
    
//    var animationHandler: SongsAnimationHandler!
    var fullSongDataSource: [SongPresentation]!
    
    public var songNumberFull: Int = 0
    
    init(audio: AudioHandler, data: [SongPresentation]) {
        super.init()
        audioPlayer = audio
//        animationHandler = animationHandle
        //fullSongDataSource = data
        song = data
        self.backgroundColor = .clear
        setupNodes()
    }
    
    override func didEnterVisibleState() {
        isPlaying = true
        NotificationCenter.default.addObserver(self, selector: #selector(songChanged), name: NSNotification.Name(rawValue: "updateUI"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(displaySong), name: NSNotification.Name(rawValue: "songDisplayer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(queuePageClosed), name: NSNotification.Name(rawValue: "closeQueuePage"), object: nil)
        
        animateCurrentSong()

    }
    
    
 
    func animateCurrentSong(){
        songCircle.openQueuePage()
        playlistImage.openQueuePage()
        playButton.openQueuePage()
        backgroundImageNode.openQueuePage()
        moreButtonNode.openQueuePage()
        songTextNode.openQueuePage()
        nameTextNode.openQueuePage()
        headphonesImageHighlighted.openQueuePage()
    }
    
    @objc func queuePageClosed() {
        songCircle.closeQueuePage()
        playlistImage.closeQueuePage()
        playButton.closeQueuePage()
        backgroundImageNode.closeQueuePage()
        moreButtonNode.closeQueuePage()
        songTextNode.closeQueuePage()
        nameTextNode.closeQueuePage()
        headphonesImageHighlighted.closeQueuePage()
        playingFrom.closeQueuePage()
        albumName.closeQueuePage()
        loopButton.closeQueuePage()
        shuffleButton.closeQueuePage()
    }
    
    override func didExitVisibleState() {
        fullSongOpen = false
    }
    
    @objc func songChanged() {
        print("QueuePageCurrent: Set Song")

        playlistImage.image = UIImage(named: fullSongImageGlobal)
        songName = fullSongNameGlobal
        songArtist = fullArtistNameGlobal
    }

    
    @objc func displaySong() {
        nameTextNode.attributedText = NSAttributedString(string: fullSongNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        songTextNode.attributedText = NSAttributedString(string: fullArtistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topControls = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 20,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [loopButton, shuffleButton])
        
        let topControlsInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 25, bottom: 0, right: 0), child: topControls)

        let title = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 5,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [playingFrom, albumName, topControlsInset])
        
        let titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 25, bottom: 0, right: 0), child: title)
        
        let hBackgroundStack = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [backgroundImageNode])
        
        let textStackStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 3,
                                                 justifyContent: .center,
                                                 alignItems: .baselineFirst,
                                                 children: [nameTextNode, songTextNode])
        
        
        let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: textStackStack)
        
        
        let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textCenter)
        
        
        
        
        let rightPadding = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 0,
                                             justifyContent: .end,
                                             alignItems: .stretch,
                                             children: [moreButtonNode])
        
        
        let moreButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 35), child: rightPadding)
        
        
        moreButtonInset.style.flexGrow = 1
        
        
        
        let headphonesCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: headphonesImageHighlighted)
        
        
        
        
        let listenOverlay = ASOverlayLayoutSpec(child: songCircle, overlay: headphonesCenter)
        
        
        
        let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
        
        
        
        
        let playlistInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImage)
        
        
        
        
        
        let playlistImageOverlay = ASOverlayLayoutSpec(child: playlistInset, overlay: listenBoxCenter)
        
        
        
        let playlistInsetOverlay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImageOverlay)
        
        
        let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 5,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [playlistInsetOverlay, textNodeInset, moreButtonInset])
        
        let fullOverlay = ASOverlayLayoutSpec(child: hBackgroundStack, overlay: hCellStack)
        
        let centerFullLayout = ASCenterLayoutSpec(centeringOptions: .X, child: fullOverlay)
        
        let topDisplay = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 5,
                                           justifyContent: .center,
                                           alignItems: .baselineFirst,
                                           children: [titleInset, centerFullLayout, bottomPadding])
        
        return topDisplay
    }
    
    func setupNodes() {
        
        //moreButtonNode.setImage(UIImage(named: "moreEllipsis"), for: .normal)
        
        let cellPadding = 40.0

        
//        songCurrentBackgroundBox.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
//        songCurrentBackgroundBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
//
//        songNameBox.attributedText = NSAttributedString(string: fullSongNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 0.3), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
//        songNameBox.frame = CGRect(x: 0, y: 0, width: 125, height: 50)
//
//        artistNameBox.attributedText = NSAttributedString(string: fullArtistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
//        artistNameBox.frame = CGRect(x: 0, y: 0, width: 125, height: 50)
//
        playingFrom.attributedText = NSAttributedString(string: "Playing From: ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        playingFrom.zPosition = 500
//
        albumName.attributedText = NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
//
//        moreButton.setImage(UIImage(named: "optionsButton"), for: .normal)

        
        backgroundImageNode.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.85)
        backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width - CGFloat(cellPadding), height: 80)
        backgroundImageNode.cornerRadius = 6
//        backgroundImageNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        bottomPadding.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 10)
        //backgroundImageNode.cornerRadius = 6
        //backgroundImageNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        playButton.image = UIImage(named: "PlayButtonDisplay")
        playButton.style.preferredSize = CGSize(width: 20, height: 20)
        playButton.alpha = 1
        playButton.zPosition = 100
        //playButton.addTarget(self, action: #selector(pauseButtonClicked), forControlEvents: .touchUpInside)

        //playlistImage.url = URL(string: ((playlistData as? SongPresentation)?.imageLink)!)
        playlistImage.image = UIImage(named: fullSongImageGlobal)
        playlistImage.style.preferredSize = .init(width: backgroundImageNode.style.preferredSize.height, height: backgroundImageNode.style.preferredSize.height)
        playlistImage.contentMode = .scaleAspectFill
        playlistImage.cornerRadius = 6
        //playlistImage.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        loopButton.image = UIImage(named: "queueLoopButton")
        loopButton.style.preferredSize = .init(width: 30, height: 30)
        loopButton.contentMode = .scaleAspectFill
        loopButton.addTarget(self, action: #selector(loopButtonClicked), forControlEvents: .touchUpInside)
//        loopButton.cornerRadius = 6
        
        shuffleButton.image = UIImage(named: "queueShuffleButton")
        shuffleButton.style.preferredSize = .init(width: 30, height: 30)
        shuffleButton.contentMode = .scaleAspectFill
        shuffleButton.addTarget(self, action: #selector(shuffleButtonClicked), forControlEvents: .touchUpInside)
//        shuffleButton.cornerRadius = 6
        
        nameTextNode.attributedText = NSAttributedString(string: fullSongNameGlobal, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        nameTextNode.maximumNumberOfLines = 2
        //nameTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        nameTextNode.style.preferredSize = .init(width: ((backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.8) - 15, height: 20)
        //nameTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        songTextNode.attributedText = NSAttributedString(string: fullArtistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        songTextNode.maximumNumberOfLines = 2
        songTextNode.style.preferredSize = .init(width: ((backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.8) - 15, height: 20)

        //songTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
    
//        moreButtonNode.setImage(UIImage(named: "queueEdit"), for: .normal)
        moreButtonNode.style.preferredSize = .init(width: (backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.2, height: 20)

        //moreButtonNode.addTarget(self, action: #selector(moreButtonClicked), forControlEvents: .touchUpInside)
        
//        songCircle.style.preferredSize = .init(width: backgroundImageNode.style.preferredSize.height, height: backgroundImageNode.style.preferredSize.height)
        songCircle.cornerRadius = 6

        songCircle.alpha = 0.7
 
        headphonesImageHighlighted.style.preferredSize = .init(width: 17, height: 17)
        headphonesImageHighlighted.contentMode = .scaleAspectFill
    }
    
    @objc func loopButtonClicked(){
        if loopButtonSelected == false {
            loopButton.image = UIImage(named: "queueLoopButtonSelected")
            loopButtonSelected = !loopButtonSelected
        }else{
            loopButton.image = UIImage(named: "queueLoopButton")
            loopButtonSelected = !loopButtonSelected
        }
    }
    
    @objc func shuffleButtonClicked(){
        if shuffleButtonSelected == false {

            shuffleButton.image = UIImage(named: "queueShuffleButtonSelected")
            shuffleButtonSelected = !shuffleButtonSelected
        }else{
            shuffleButton.image = UIImage(named: "queueShuffleButton")
            shuffleButtonSelected = !shuffleButtonSelected
        }
    }
}

extension ASImageNode {
    func openQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition + 50
        move.toValue = initialPosition
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
        
    }
    
    func shadowEaseIn() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.3
        fadeOut.toValue = 0.7
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
    }
    
    func shadowEaseOut() {
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.7
        fadeOut.toValue = 0.3
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
    }
    
    func closeQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 50
        move.duration = 0.2
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.2
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
    }
}

extension ASTextNode {
    
    func openQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition + 50
        move.toValue = initialPosition
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 1
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
    }
    
    func closeQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 50
        move.duration = 0.2
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.2
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
    }
}

extension ASButtonNode {
    
    func openQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition + 80
        move.toValue = initialPosition
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 0.0
        fadeOut.toValue = 1.0
        fadeOut.duration = 1
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
        
    }
    
    func closeQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 50
        move.duration = 0.2
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.2
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
    }
}
