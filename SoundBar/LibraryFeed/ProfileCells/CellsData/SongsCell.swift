//
//  SongsCell.swift
//  SoundBar
//
//  Created by Justin Cose on 2020-08-23.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var indexPathRow = Int()
var playlistEdit = false
var fullSongLinkGlobal = ""

var iconsSwitched = false

var fullSongPageData: SongPresentation!

protocol SongsCellDelegate: AnyObject {
    func delete(cell: SongsCell)
}

protocol SongsPlaylistCellDelegate: AnyObject {
    func delete(playlistCell: SongsCell)
    func deleteTemp(tempCell: SongsCell)
}

var songsCellData: [SongPresentation] = [SongPresentation]()

class SongsCell: BaseCellNode {

    var song: SongPresentation!

    var circlePath = UIBezierPath()
    var songCircle = CAShapeLayer()

    var backgroundCell = ASImageNode()
    var lineSeperator = ASImageNode()
    
    let songImage = ASImageNode()
    let textNode = ASTextNode()
    let backgroundImageNode = ASImageNode()
    
    let listensNode = ASButtonNode()
    let listenCount = ASTextNode()
    let headphonesImage = ASImageNode()
    
    var moreCircle = ASImageNode()
    var moreIcon = ASImageNode()
    
    let nameTextNode = ASTextNode()
    let songTextNode = ASTextNode()
    
    var songBox = ASImageNode()
    var nameBox = ASImageNode()
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    var textType: String = "Favorites"
    
    weak var delegate : SongsCellDelegate?
    weak var delegatePlaylist : SongsPlaylistCellDelegate?

    init(type: String = "Favorites", clickedSong: SongPresentation, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        
        song = clickedSong
        audioPlayer = audio
        animationHandler = animationHandle
        textType = type
        
        if (!bottomSongDisplayLoaded) {
            globalAudioPlayer = audio
        }
  
        setupNodes()
        setUpObservers()
    }
    
    func setUpObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(songDelete(_:)), name: NSNotification.Name("cellDelete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToPlaylistView), name: NSNotification.Name("switchToPlaylistView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchToSendFeed), name: NSNotification.Name("switchToSendFeed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreateExit), name: NSNotification.Name("playlistCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playlistCreateExit), name: NSNotification.Name("cancelClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(editPlaylist), name: NSNotification.Name("editPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("createNewPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("addSongToPlaylist"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("switchIconToAdd"), object: nil)
    }
    
    override func didEnterVisibleState() {
        circlePath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 30, startAngle: CGFloat(-Double.pi / 2.0), endAngle: CGFloat(Double.pi * 2.0) + CGFloat(-Double.pi / 2.0), clockwise: true)
        
        songCircle = CAShapeLayer()
        songCircle.path = circlePath.cgPath
        songCircle.fillColor = UIColor.clear.cgColor
        songCircle.strokeColor = UIColor.white.cgColor
        songCircle.lineWidth = 2.0
        songCircle.strokeEnd = 0.0
        songCircle.position = CGPoint(x: listensNode.position.x, y: listensNode.position.y)
        view.layer.addSublayer(songCircle)
        
        if playlistEdit {
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(editPlaylistState), forControlEvents: .touchUpInside)
        }
        else if currentlyCreatingPlaylist {
            if iconsSwitched == false {
                moreIcon.image = UIImage(named: "AddPlaylistIcon")
            }
            iconsSwitched = true
            
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(creatingPlaylistState), forControlEvents: .touchUpInside)
            
        }
        else {
            moreIcon.image = UIImage(named: "MoreIconCircles")
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(defaultState), forControlEvents: .touchUpInside)
        }
    }
    
    @objc func switchToPlaylistView(){
        self.closestViewController?.present(AddToPlaylistViewController(), animated: true, completion: nil)
    }
    
    @objc func switchToSendFeed(){
        self.closestViewController?.present(SendFeedViewController(), animated: true, completion: nil)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let hBackgroundStack = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [backgroundImageNode])
        
        let songOverlay = ASOverlayLayoutSpec(child: songBox, overlay: songTextNode)
        let nameOverlay = ASOverlayLayoutSpec(child: nameBox, overlay: nameTextNode)
        
        let textStackStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 3,
                                                 justifyContent: .center,
                                                 alignItems: .baselineFirst,
                                                 children: [songOverlay, nameOverlay])
        
        let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: textStackStack)
        
        let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textCenter)
 
        let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [headphonesImage, listenCount])
        
        let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)
        
        let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: vStackListenCenter)
        
        let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)

        let playlistInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: songImage)
        
        let songImageOverlay = ASOverlayLayoutSpec(child: playlistInset, overlay: listenBoxCenter)
        
        let playlistInsetOverlay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: songImageOverlay)
        
        let moreIconSpec = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [moreIcon])
        
        let moreOverlay = ASOverlayLayoutSpec(child: moreCircle, overlay: moreIconSpec)
        
        let moreEndInset = ASStackLayoutSpec(direction: .horizontal,
                                             spacing: 0,
                                             justifyContent: .end,
                                             alignItems: .center,
                                             children: [moreOverlay])
        
        let moreEndInsetRight = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 15), child: moreEndInset)
        
        let moreOverlayOnCell = ASOverlayLayoutSpec(child: backgroundCell, overlay: moreEndInsetRight)

        
        let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 5,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [playlistInsetOverlay, textNodeInset])
        
        let fullCellStack = ASOverlayLayoutSpec(child: moreOverlayOnCell, overlay: hCellStack)
        
        let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [fullCellStack, lineSeperator])

        return fullStackLine
    }
    
    private func setupNodes() {
        songImage.image = UIImage(named: song.imageLink ?? "")
        songImage.style.preferredSize = .init(width: 110, height: 110)
        songImage.contentMode = .scaleAspectFill
        songImage.cornerRadius = 0
        songImage.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        lineSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        lineSeperator.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        
        backgroundCell.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
        backgroundCell.backgroundColor = UIColor().cellBackgroundGray()
        
        backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 110)
        backgroundImageNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        songTextNode.attributedText = NSAttributedString(string: song.songName ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        songTextNode.maximumNumberOfLines = 2
        songTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        nameTextNode.attributedText = NSAttributedString(string: song.artistID ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        nameTextNode.maximumNumberOfLines = 2
        nameTextNode.addTarget(self, action: #selector(songClicked), forControlEvents: .touchUpInside)
        
        songBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.9, height: 20)
        nameBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.9, height: 20)

        moreIcon.style.preferredSize = .init(width: 30, height: 30)
    
        moreCircle.style.preferredSize = .init(width: 50, height: 50)
        moreCircle.cornerRadius = 30/2
        
        if playlistEdit {
            if currentlyCreatingPlaylist == false {
                moreIcon.image = UIImage(named: "removeSongIcon")
            }
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(editPlaylistState), forControlEvents: .touchUpInside)
        }
        
        else if currentlyCreatingPlaylist {
            moreIcon.image = UIImage(named: "AddPlaylistIcon")
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(creatingPlaylistState), forControlEvents: .touchUpInside)
        }
        
        else {
            moreIcon.image = UIImage(named: "MoreIconCircles")
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(defaultState), forControlEvents: .touchUpInside)
        }

        listensNode.style.preferredSize = .init(width: 60, height: 60)
        listensNode.cornerRadius = 60/2
        listensNode.backgroundColor = .init(white: 0.0, alpha: 0.7)
        listensNode.addTarget(self, action: #selector(songPreview), forControlEvents: .touchUpInside)
        
        headphonesImage.style.preferredSize = .init(width: 17, height: 17)
        headphonesImage.image = .init(imageLiteralResourceName: "headphones")
        
        listenCount.attributedText = NSAttributedString(string: "\(formatNumber(song.listens!))", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
    }
    
    @objc func defaultState() {
        if songCellCurrent.count == 0 {
            songCellCurrent.append(self)
        }
        
        else {
            songCellCurrent[0] = self
        }
    
        if playlistOpened == true { moreType = "PlaylistSong" } else { moreType = "Song" }
        titleOneGlobal = song.songName ?? ""
        titleTwoGlobal = song.artistID ?? ""
        contentImageGlobal = song.imageLink ?? ""
        
        popUpHeight = (460 / UIScreen.main.bounds.height)
        popUpPosition = 1 - (460 / UIScreen.main.bounds.height)
        
        NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
    }
    
    @objc func createNewPlaylist() {
        if iconsSwitched == false{
            moreIcon.image = UIImage(named: "AddPlaylistIcon")
        }
        moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
        moreCircle.addTarget(self, action: #selector(creatingPlaylistState), forControlEvents: .touchUpInside)
    }
    
    @objc func creatingPlaylistState(){
        songsCellData.append(song)
        songsCellArray.append(self)

        if playlistEdit == false {
            moreIcon.image = UIImage(named: "addCheckMarkIcon")
        }
    }
    
    @objc func editPlaylist() {
        if currentlyCreatingPlaylist == false{
            moreIcon.image = UIImage(named: "removeSongIcon")
        }
        moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
        moreCircle.addTarget(self, action: #selector(editPlaylistState), forControlEvents: .touchUpInside)
    }
    
    @objc func editPlaylistState(){
        var index: Int!
        for songCell in songsCellArray {
            if songCell.song.songName == self.song.songName {
                songCell.moreIcon.image = UIImage(named: "addCheckMarkIcon")
                index = songsCellData.firstIndex{ $0.songName == self.song.songName } ?? 0

            }
        }
        delegatePlaylist?.deleteTemp(tempCell: self)
        songsCellData.remove(at: index)
        songsCellArray.remove(at: index)
    }
    
    @objc func playlistCreateExit(){
        moreIcon.image = UIImage(named: "MoreIconCircles")
        moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
        moreCircle.addTarget(self, action: #selector(defaultState), forControlEvents: .touchUpInside)
        
        playlistEdit = false
        currentlyCreatingPlaylist = false
    }
    
    @objc func songPreview() {
        fullSongOpen = false

        animationHandler.setSongCircle(shapeLayer: songCircle)

        audioPlayer.pauseCurrentSong()
        audioPlayer.setSnippetAudioLink(snippetLink: song.snippetLink ?? "")
        audioPlayer.setFullAudioLink(fullLink: song.fullLink ?? "")
                
        if currentObj == nil {
            isPlaying = false
            currentObj = songCircle
        }
        if currentObj == songCircle {
            if isPlaying {
                audioPlayer.pauseCurrentSong()
                audioPlayer.restart()
                animationHandler.removeCircleAnimations()
            }
            else {
                audioPlayer.unpauseCurrentSong()
                animationHandler.animateCircle()
            }
            isPlaying = !isPlaying
        }
        else {
            audioPlayer.unpauseCurrentSong()
            animationHandler.completeCircleAnimation(shapeLayer: currentObj!)
            animationHandler.animateCircle()
            
            currentObj = songCircle
            isPlaying = true
        }
    }
    
    @objc func songClicked() {
        fullSongOpen = true
        fullSongPageData = song
        fullSongImageGlobal = song.imageLink ?? ""
        artistPFPGlobal = song.profileImageLink ?? ""
        fullSongNameGlobal = song.songName ?? ""
        fullArtistNameGlobal = song.artistID ?? ""
        fullSongLinkGlobal = song.fullLink ?? ""
        
        globalAudioPlayer?.setFullAudioLink(fullLink: song.fullLink!)
        globalAudioPlayer?.setSnippetAudioLink(snippetLink: song.snippetLink!)
        globalAudioPlayer?.playFullSong()
        
        audioDurationGlobal = globalAudioPlayer?.getFullPlayerItem.asset.duration.seconds
        NotificationCenter.default.post(name: Notification.Name("pauseIcon"), object: nil)
        
        if textType == "Recommended" {
            NotificationCenter.default.post(name: NSNotification.Name("switchBottomSongDisplayData"), object: nil, userInfo: ["data" : "recommended"])
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("setSongNameAndImage"), object: nil, userInfo: ["name": song.songName!, "image": song.imageLink!])

        if (CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1).value < 0){
            audioCurrentTime = CMTime(seconds: 0, preferredTimescale: 1)
        }
        
        else{
            audioCurrentTime = CMTime(seconds: Double(globalSongDisplayNode?.audioPlayer.getCurrentTime() ?? 0), preferredTimescale: 1)

        }
        
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayer"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayAnimation"), object: nil)

        if playlistOpened  && playlistEdit == false{
            let vc = FullSongPageViewController(audio: globalSongDisplayNode?.audioPlayer ?? AudioHandler())
            vc.modalPresentationStyle = .fullScreen
            self.closestViewController?.present(vc, animated: true, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name("fullSongToggle"), object: nil)
        }
    }
    
    @objc func songDelete(_ notification: NSNotification){
        if playlistOpened {
            if let cell = notification.userInfo?["SongsCell"] as? SongsCell {
                delegatePlaylist?.delete(playlistCell: cell)
            }
        }
        
        else{
            if let cell = notification.userInfo?["SongsCell"] as? SongsCell {
                delegate?.delete(cell: cell)
            }
            else{
                delegate?.delete(cell: self)
            }
        }
    }
}



          
