//
//  PlaylistsCell.swift
//  SoundBar
//
//  Created by Justin Cose on 2021-07-15.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var morePlaylistImage = String()
var morePlaylistName = String()
var morePlaylistCreatedBy = String()
var playlistOpened = false

protocol PlaylistsCellDelegate: AnyObject {
    func delete(cell: PlaylistsCell)
}

var playlistsCellData:[String: PlaylistsCell]?
var lastClickedButton: ASImageNode? = nil

class PlaylistsCell: BaseCellNode {
    
    var backgroundCell = ASImageNode()
    var lineSeperator = ASImageNode()
    var playlistImage = ASImageNode()
    var playlistImageTwo = ASImageNode()
    var songsArray = hotBarsDataSourceStatic
    
    let collectionImage = ASImageNode()

    let songCount = ASTextNode()
    
    var playlistStarted = false

    let playlistName = ASTextNode()
    var createdByString = String()
    var createdBy = ASTextNode()
    
    var songBox = ASImageNode()
    var nameBox = ASImageNode()
    
    var imageReroll = Int.random(in: 0..<3)
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    var emptyCellOne = ASImageNode()
    var emptyCellTwo = ASImageNode()
    
    var moreCircle = ASImageNode()
    var moreIcon = ASImageNode()
        
    var playlist: SongPlaylists!
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    var moreCreatedByString = String()
    
    var imageBox = ASImageNode()

    weak var delegate : PlaylistsCellDelegate?
    
    init(playlist: SongPlaylists, createdBy: String, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("createNewPlaylist"), object: nil)

        songsArray.shuffle()
        audioPlayer = audio
        animationHandler = animationHandle
        self.playlist = playlist
        createdByString = playlist.creator
        setupNodes()
    }
    
    override func didEnterVisibleState() {
        NotificationCenter.default.addObserver(self, selector: #selector(playlistsDelete(_:)), name: NSNotification.Name("cellDelete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cancelPlaylistCreate), name: NSNotification.Name("cancelClicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(createNewPlaylist), name: NSNotification.Name("editPlaylist"), object: nil)
        
        isPlaying = true
        fullSongOpen = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let songOverlay = ASOverlayLayoutSpec(child: songBox, overlay: playlistName)
        let nameOverlay = ASOverlayLayoutSpec(child: nameBox, overlay: createdBy)
        
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 1,
                                          justifyContent: .center,
                                          alignItems: .baselineFirst,
                                          children: [songOverlay, nameOverlay])
        
        
        let textStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: textStack)
        
        var songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [songImageTopLeft, songImageTopRight])
        
        var songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [songImageBottomLeft, songImageBottomRight])
        
        if(self.playlist.songs?.count == 0){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [])

            songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [])
        }
        
        else if(self.playlist.songs?.count == 1){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImage])
            songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [])
        }
        
        else if(self.playlist.songs?.count == 2){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImage])
            songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImageTwo])
        }
        
        else if(self.playlist.songs?.count == 3){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [songImageTopLeft, songImageTopRight])
            songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImageTwo])
        }
        
        else if(self.playlist.songs!.count >= 4){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [songImageTopLeft, songImageTopRight])
            songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [songImageBottomLeft, songImageBottomRight])
        }
        
        let songsStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [songsTopStack, songsBottomStack])
        
        let songsBox = ASOverlayLayoutSpec(child: imageBox, overlay: songsStack)

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
        
        let playlistStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 5,
                                              justifyContent: .start,
                                              alignItems: .center,
                                              children: [songsBox, textStackInset])
        
        let fullCellStack = ASOverlayLayoutSpec(child: moreOverlayOnCell, overlay: playlistStack)
        
        
        let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [fullCellStack, lineSeperator])

        
    
        return fullStackLine
    }
    
    private func setupNodes() {
        if currentlyCreatingPlaylist == false {
            moreIcon.image = UIImage(named: "MoreIconCircles")
        }
        else{
            moreIcon.image = UIImage(named: "AddPlaylistIcon")
            moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
            moreCircle.addTarget(self, action: #selector(addPlaylist), forControlEvents: .touchUpInside)
        }
        
        imageBox.style.preferredSize = .init(width: 110, height: 110)
        print("imageBox Height: \(imageBox.style.preferredSize.height)")
        
        lineSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        lineSeperator.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        
        backgroundCell.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
        backgroundCell.backgroundColor = UIColor().cellBackgroundGray()
        
        emptyCellOne.style.preferredSize = .init(width: 95/2, height: 95/2)
        emptyCellOne.cornerRadius = 0
        emptyCellOne.borderWidth = 0
        emptyCellOne.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        emptyCellTwo.style.preferredSize = .init(width: 95/2, height: 95/2)
        emptyCellTwo.cornerRadius = 0
        emptyCellTwo.borderWidth = 0
        emptyCellTwo.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        collectionImage.image = UIImage(named: playlist.imageLink)
        collectionImage.style.preferredSize = .init(width: 95, height: 95)
        collectionImage.cornerRadius = 0
        collectionImage.borderWidth = 1
        collectionImage.borderColor = UIColor.white.cgColor
        collectionImage.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        songImageTopLeft.image = UIImage(named: playlist .imageLink ?? "")
        songImageTopLeft.style.preferredSize = .init(width: 95/2, height: 95/2)
        songImageTopLeft.cornerRadius = 0
        songImageTopLeft.borderWidth = 0.25
        songImageTopLeft.borderColor = UIColor.white.cgColor
        songImageTopLeft.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
    
        songImageTopRight.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageTopRight.style.preferredSize = .init(width: 95/2, height: 95/2)
        songImageTopRight.cornerRadius = 0
        songImageTopRight.borderWidth = 0.25
        songImageTopRight.borderColor = UIColor.white.cgColor
        songImageTopRight.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        songImageBottomLeft.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageBottomLeft.style.preferredSize = .init(width: 95/2, height: 95/2)
        songImageBottomLeft.cornerRadius = 0
        songImageBottomLeft.borderWidth = 0.25
        songImageBottomLeft.borderColor = UIColor.white.cgColor
        songImageBottomLeft.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        songImageBottomRight.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageBottomRight.style.preferredSize = .init(width: 95/2, height: 95/2)
        songImageBottomRight.cornerRadius = 0
        songImageBottomRight.borderWidth = 0.25
        songImageBottomRight.borderColor = UIColor.white.cgColor
        songImageBottomRight.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        moreIcon.style.preferredSize = .init(width: 30, height: 30)

        moreCircle.style.preferredSize = .init(width: 50, height: 50)
        moreCircle.cornerRadius = 30/2

        if currentlyCreatingPlaylist {
            moreCircle.addTarget(self, action: #selector(addPlaylist), forControlEvents: .touchUpInside)
        }
        else{
            moreCircle.addTarget(self, action: #selector(moreButtonClicked), forControlEvents: .touchUpInside)
        }

        songBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.9, height: 20)
        nameBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.9, height: 20)
        
        playlistName.attributedText = NSAttributedString(string: playlist.playlistName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        
        moreCreatedByString = "Created by: \(createdByString)"
        
        if createdByString == "You" {
            let textString = NSMutableAttributedString(string: "Created by: \(createdByString)")
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSRange(location: 0,length: 11))
            textString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor().soundbarColorScheme(), range: NSRange(location: 12,length: 3))
            textString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 12), range: NSRange(location: 0,length: 15))
            createdBy.attributedText = textString
        }
        else {
            createdBy.attributedText = NSAttributedString(string: "Created by: \(createdByString)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        }
        
        songCount.attributedText = NSAttributedString(string: "\(playlist.songs?.count ?? 0) songs", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        songCount.style.preferredSize = CGSize(width: 200, height: 17)
        songCount.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        if playlist.songs?.count == 1 {
            playlistImage.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 95, height: 95)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
        }
        else if playlist.songs?.count == 2{
            playlistImage.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 95, height: 95/2)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
            
            playlistImageTwo.image = UIImage(named: playlist.songs?[1].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 95, height: 95/2)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        else if playlist.songs?.count == 3{
            songImageTopLeft.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlist.songs?[1].imageLink ?? "")

            playlistImageTwo.image = UIImage(named: playlist.songs?[2].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 95, height: 95/2)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        else if playlist.songs!.count >= 4{
            songImageTopLeft.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlist.songs?[1].imageLink ?? "")
            songImageBottomLeft.image = UIImage(named: playlist.songs?[2].imageLink ?? "")
            songImageBottomRight.image = UIImage(named: playlist.songs?[3].imageLink ?? "")
        }
        else{
            playlistImage.style.preferredSize = CGSize(width: 95, height: 95)
            playlistImage.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            playlistImage.borderWidth = 1
        }
    }
    
    @objc func createNewPlaylist() {
        if iconsSwitched == false {
            moreIcon.image = UIImage(named: "AddPlaylistIcon")
        }
        moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
        moreCircle.addTarget(self, action: #selector(addPlaylist), forControlEvents: .touchUpInside)
    }
    
    @objc func addPlaylist() {
        var newCellData: [SongPresentation] = [SongPresentation]()
        var newCellArray: [SongsCell] = []
        for song in playlist.songs! {
            newCellData.append(song)
            newCellArray.append(SongsCell(clickedSong: song, audio: audioPlayer, animationHandle: animationHandler))
        }
        if currentlyCreatingPlaylist == false {
            songsCellData = newCellData
            songsCellArray = newCellArray
        }
        else{
            for song in playlist.songs! {
                songsCellData.append(song)
                songsCellArray.append(SongsCell(clickedSong: song, audio: audioPlayer, animationHandle: animationHandler))
            }
        }
        moreIcon.image = UIImage(named: "addCheckMarkIcon")
    }
    
    @objc func moreButtonClicked() {
        moreType = "Playlist"
        
        playlistsCellData = ["PlaylistsCell": self]
        
        if playlistEdit != true {
            morePlaylistImage = self.playlist.imageLink ?? ""
            playlistNameGlobal = self.playlist.playlistName ?? ""
            morePlaylistCreatedBy = self.playlist.creator ?? ""
        }
       
        titleOneGlobal = playlist.playlistName ?? ""
        titleTwoGlobal = playlist.creator ?? ""
        contentImageGlobal = playlist.imageLink ?? ""
        
        popUpHeight = (410 / UIScreen.main.bounds.height)
        popUpPosition = 1 - (410 / UIScreen.main.bounds.height)
        
        NotificationCenter.default.post(name: Notification.Name("loadSharePopUp"), object: nil)
    }
    
    @objc func playlistsDelete(_ notification: NSNotification){
        if let cell = notification.userInfo?["PlaylistsCell"] as? PlaylistsCell {
            delegate?.delete(cell: cell)
        }
    }

    @objc func cancelPlaylistCreate(){
        moreIcon.image = UIImage(named: "MoreIconCircles")
        playlistEdit = false
        currentlyCreatingPlaylist = false
        moreCircle.removeTarget(self, action: nil, forControlEvents: .allEvents)
        moreCircle.addTarget(self, action: #selector(moreButtonClicked), forControlEvents: .touchUpInside)
    }
    
    @objc func shufflePlaylist() {
        fullSongOpen = true
        let randomSong = Int.random(in: 0..<playlist.songs!.count)
        self.audioPlayer.setDatasourceSongNumber(number: randomSong)
        NotificationCenter.default.post(name: NSNotification.Name("switchFullSongData"), object: nil, userInfo: ["songs" : playlist.songs!])
        
        fullSongImageGlobal = playlist.songs![randomSong].imageLink ?? ""
        artistPFPGlobal = playlist.songs![randomSong].profileImageLink ?? ""
        fullSongNameGlobal = playlist.songs![randomSong].songName ?? ""
        fullArtistNameGlobal = playlist.songs![randomSong].artistID ?? ""
        
        NotificationCenter.default.post(name: NSNotification.Name("setSongNameAndImage"), object: nil, userInfo: ["name": playlist.songs![randomSong].songName ?? "", "image": playlist.songs![randomSong].imageLink ?? ""])
        
        audioPlayer.setFullAudioLink(fullLink: playlist.songs![randomSong].fullLink!)
        audioPlayer.setSnippetAudioLink(snippetLink: playlist.songs![randomSong].snippetLink!)
        
        audioPlayer.unpauseCurrentSong()
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayer"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("songDisplayAnimation"), object: nil)
    }
    
    @objc func playlistClicked() {
        playlistImageGlobal = playlist.imageLink
        playlistNameGlobal = playlist.playlistName
        playlistCreatorGlobal = createdByString

        playlistOpened = true
        audioPlayer.pauseCurrentSong()
        playlistsCellData = ["PlaylistsCell": self]
        playlistNameGlobal = playlistName.attributedText?.string ?? ""
        songsCellData = playlist.songs!

        let vc = PlaylistPageViewController(audio: audioPlayer, playlistSongs: songsCellData, animationHandle: animationHandler)
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}

     


