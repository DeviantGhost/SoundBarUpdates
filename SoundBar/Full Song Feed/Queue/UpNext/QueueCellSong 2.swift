//
//  PlaylistCellData.swift
//  SoundBar
//
//  Created by Justin Cose on 2020-08-23.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

protocol QueueCellDelegate: AnyObject {
    func delete(cell: QueueCellSong)
}

class QueueCellSong: BaseCellNode {

    var song: SongPresentation!
    
    var didLoad = false
    
    var songCircle = ASImageNode()
    
    let playlistImage = ASImageNode()
    
    let textNode = ASTextNode()
    
    let backgroundImageNode = ASImageNode()
    let moreButtonNode = ASButtonNode()
    
    let listensNode = ASButtonNode()
    
    let playButton = ASImageNode()
    
    let nameTextNode = ASTextNode()
    let songTextNode = ASTextNode()
    
    var audioPlayer: AudioHandler!
    
    let headphonesImage = ASImageNode()

//    var animationHandler: SongsAnimationHandler!
    weak var delegate : QueueCellDelegate?
    
    init(clickedSong: SongPresentation, audio: AudioHandler) {
        super.init()
        song = clickedSong
        if (!bottomSongDisplayLoaded) {
            globalAudioPlayer = audio
        }
        audioPlayer = audio
//        animationHandler = animationHandle
      
        setupNodes()
    }
    
    override func didEnterVisibleState() {
        if didLoad == false {
            self.openQueuePage()
            didLoad = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(queuePageClosed), name: NSNotification.Name(rawValue: "closeQueuePage"), object: nil)

    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
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
        
        
        
        let playButtonCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: headphonesImage)
        
        
        
        
        let listenOverlay = ASOverlayLayoutSpec(child: songCircle, overlay: playButtonCenter)
        
        
        
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

        return centerFullLayout
        
    }
    
    @objc func queuePageClosed() {
        self.closeQueuePage()

        
    }
    
    private func setupNodes() {
        let cellPadding = 40.0
        
        backgroundImageNode.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 0.85)
        backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width - CGFloat(cellPadding), height: 80)
        backgroundImageNode.cornerRadius = 6
        backgroundImageNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        playButton.image = UIImage(named: "PlayButtonDisplay")
        playButton.style.preferredSize = CGSize(width: 20, height: 20)
        playButton.alpha = 1
        playButton.zPosition = 100
        
        //playlistImage.url = URL(string: ((playlistData as? SongPresentation)?.imageLink)!)
        playlistImage.image = UIImage(named: song.imageLink ?? "")
        playlistImage.style.preferredSize = .init(width: backgroundImageNode.style.preferredSize.height, height: backgroundImageNode.style.preferredSize.height)
        playlistImage.contentMode = .scaleAspectFill
        playlistImage.cornerRadius = 6
        playlistImage.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
    
        moreButtonNode.setImage(UIImage(named: "queueEdit"), for: .normal)
        moreButtonNode.addTarget(self, action: #selector(moreButtonClicked), forControlEvents: .touchUpInside)
        moreButtonNode.style.preferredSize = .init(width: (backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.2, height: 20)
        
        songCircle.style.preferredSize = .init(width: backgroundImageNode.style.preferredSize.height, height: backgroundImageNode.style.preferredSize.height)
        songCircle.cornerRadius = 6
//        songCircle.backgroundColor = .init(white: 0.0, alpha: 0.8)
        songCircle.alpha = 0.7
        songCircle.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        
        nameTextNode.attributedText = NSAttributedString(string: song.artistID ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        nameTextNode.maximumNumberOfLines = 2
        nameTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        nameTextNode.style.preferredSize = .init(width: ((backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.8) - 15, height: 20)

        songTextNode.attributedText = NSAttributedString(string: song.songName ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        songTextNode.maximumNumberOfLines = 2
        songTextNode.style.preferredSize = .init(width: ((backgroundImageNode.style.preferredSize.width - backgroundImageNode.style.preferredSize.height) * 0.8) - 15, height: 20)
        songTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
//        songTextNode.backgroundColor = .black
        
        headphonesImage.style.preferredSize = .init(width: 17, height: 17)
//        headphonesImage.image = UIImage(named: "headphones")
        
        
    }
    
    @objc private func moreButtonClicked() {
        
    }
    
    
    
    
    @objc func songClicked() {
        print("recommended clicked")
        
        fullSongOpen = true
        
        fullSongImageGlobal = song.imageLink ?? ""
        artistPFPGlobal = song.profileImageLink ?? ""
        fullSongNameGlobal = song.songName ?? ""
        fullArtistNameGlobal = song.artistID ?? ""
        fullSongLinkGlobal = song.fullLink ?? ""

        globalAudioPlayer?.setFullAudioLink(fullLink: song.fullLink!)
        globalAudioPlayer?.setSnippetAudioLink(snippetLink: song.snippetLink!)
        
        audioPlayer.playFullSong()

        audioDurationGlobal = globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds
        NotificationCenter.default.post(name: Notification.Name("pauseIcon"), object: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("setSongNameAndArtist"), object: nil, userInfo: ["name": song.songName!, "artist": song.artistID!])
//        print("node: recommended clicked \((playlistData as? SongPresentation)!.songName!)")
        
        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)

        }
        
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayer"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayAnimation"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("updateUI"), object: nil)
        
        delegate?.delete(cell: self)
    }
    
    
}


extension BaseCellNode {
    
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
    
    func closeQueuePage() {
        let initialPosition = self.position.y
        let move = CASpringAnimation(keyPath: "position.y")
        
        move.fillMode = .forwards
        move.isRemovedOnCompletion = false
        move.fromValue = initialPosition
        move.toValue = initialPosition + 50
        move.duration = 1
        move.damping = 17.5
        move.initialVelocity = 2
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1.0
        fadeOut.toValue = 0.0
        fadeOut.duration = 0.5
        fadeOut.setValue("video", forKey:"fadeOut")
        fadeOut.isRemovedOnCompletion = false
        fadeOut.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(fadeOut, forKey: "opacity")
        self.layer.add(move, forKey: "position.y")
    }
        
}
