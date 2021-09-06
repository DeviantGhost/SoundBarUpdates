//
//  TopDisplay.swift
//  SoundBar
//
//  Created by Justin Cose on 2/26/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

let newPlaylistImages = [String]()

class TopDisplay: BaseCellNode, ASEditableTextNodeDelegate {
    
    var playlistTitle = ASEditableTextNode()
    var playlistCreator = ASTextNode()
    var by = ASTextNode()
    var shuffleText = ASTextNode()
    var lastUpdate = ASTextNode()
    var lastUpdateTimeStamp = ASTextNode()
    var playlistBio = ASTextNode()
    var playlistImage = ASImageNode()
    var playlistImageTwo = ASImageNode()

    var shuffleIcon = ASImageNode()
    var playIcon = ASImageNode()

    var playlistImageBackground = ASImageNode()
    var shadowBackground = ASImageNode()
    let collectionImage = ASImageNode()

    var shuffleButtonBackground = ASImageNode()
    var playButtonBackground = ASImageNode()

    var addSongtext = ASTextNode()
    
    var shuffleCounterWeight = ASImageNode()
    
    var cameraIcon = ASImageNode()
    var cameraBackground = ASImageNode()
    
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    
    var emptyCellOne = ASImageNode()
    var emptyCellTwo = ASImageNode()
    var createdByString = String()

    var songs: [SongPresentation]!
    
    var topDisplayBox = ASImageNode()
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    lazy var titleInset = playlistName.count * 7

    
    var liked = false
    

    init(songs: [SongPresentation]?, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()

        self.songs = songs
        audioPlayer = audio
        animationHandler = animationHandle
        
        setupNodes()
    }
 
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        let artistText = ASStackLayoutSpec(direction: .horizontal,
                                         spacing: 4,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [by, playlistCreator])
        
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 4,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [playlistTitle, artistText])
        
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
        let vStackCamera = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [cameraIcon])
        
        let cameraInset = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackCamera)
        
        if(self.songs.count == 0) {
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
        
        else if(self.songs.count == 1) {
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImage])
        }
        
        else if(self.songs.count == 2) {
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
        
        else if(self.songs.count == 3){
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
        
        else if(self.songs.count >= 4){
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
        
        var songsStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [songsTopStack, songsBottomStack])
        
        if(self.songs.count == 1) {
            songsStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [songsTopStack])
        }
        
        let songsOverlay = ASOverlayLayoutSpec(child: collectionImage, overlay: songsStack)

        let textInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: textStack)
        
        let vShuffleStack = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [shuffleIcon])
        
        let vPlayStack = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [playIcon])
        
        let shuffleOverlay = ASOverlayLayoutSpec(child: shuffleButtonBackground, overlay: vShuffleStack)

        let playOverlay = ASOverlayLayoutSpec(child: playButtonBackground, overlay: vPlayStack)

        let topDisplayControlStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 30,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [playOverlay, shuffleOverlay])

        var topStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 15,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [songsOverlay, textInset, topDisplayControlStack])
        if playlistEdit {
            let centerTextLayout = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [addSongtext])
            
            let songsTextOverlay = ASOverlayLayoutSpec(child: shuffleButtonBackground, overlay: centerTextLayout)

            let centerSongTextLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: songsTextOverlay)
            
            let cameraOverlay = ASOverlayLayoutSpec(child: cameraBackground, overlay: cameraInset)

            let cameraCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: cameraOverlay)
            
            let topImageOverlay = ASOverlayLayoutSpec(child: songsOverlay, overlay: cameraCenter)
                        
            topStack = ASStackLayoutSpec(direction: .vertical,
                                         spacing: 15,
                                         justifyContent: .center,
                                         alignItems: .center,
                                         children: [topImageOverlay, textInset, centerSongTextLayout])
        }
        
        let topStackInset = ASInsetLayoutSpec(insets: .init(top: 40, left: 0, bottom: 0, right: 0), child: topStack)
        
        let centerStackLayout = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: topStackInset)
        
        let stackOverlay = ASOverlayLayoutSpec(child: playlistImageBackground, overlay: centerStackLayout)

        let stackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: stackOverlay)
        
        return stackInset
    }
    
    
    @objc func donePlaylist(){
        addSongtext.alpha = 0
        shuffleIcon.alpha = 1
    }
    
    private func setupNodes() {
        shuffleText.attributedText = NSAttributedString(string: "Shuffle", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])
        addSongtext.attributedText = NSAttributedString(string: "Add Songs", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        cameraBackground.style.preferredSize = CGSize(width: 80, height: 80)
        cameraBackground.cornerRadius = 80/2
        cameraBackground.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        cameraBackground.alpha = 0.7
        
        cameraIcon.image = UIImage(named: "camera")
        cameraIcon.contentMode = .scaleAspectFill
        cameraIcon.clipsToBounds = true
        cameraIcon.style.preferredSize = .init(width: 40, height: 40)
        
        if songs.count == 1 {
            playlistImage.image = UIImage(named: songs[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 122, height: 122)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
        }
        
        else if songs.count == 2{
            playlistImage.style.preferredSize = CGSize(width: 122, height: 61)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
            playlistImage.image = UIImage(named: songs[0].imageLink ?? "")
            
            playlistImageTwo.image = UIImage(named: songs[1].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 122, height: 61)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true

        }
        
        else if songs.count == 3{
            songImageTopLeft.image = UIImage(named: songs[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: songs[1].imageLink ?? "")

            playlistImageTwo.image = UIImage(named: songs[2].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 122, height: 61)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        
        else if songs.count >= 4{
            songImageTopLeft.image = UIImage(named: songs[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: songs[1].imageLink ?? "")
            songImageBottomLeft.image = UIImage(named: songs[2].imageLink ?? "")
            songImageBottomRight.image = UIImage(named: songs[3].imageLink ?? "")
        }
        
        else {
            playlistImage.style.preferredSize = CGSize(width: 124, height: 124)
            playlistImage.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            playlistImage.borderWidth = 1
        }
        
        emptyCellOne.style.preferredSize = .init(width: 61, height: 61)
        emptyCellOne.cornerRadius = 0
        emptyCellOne.borderWidth = 0
        
        emptyCellTwo.style.preferredSize = .init(width: 61, height: 61)
        emptyCellTwo.cornerRadius = 0
        emptyCellTwo.borderWidth = 0
        
        songImageTopLeft.style.preferredSize = .init(width: 61, height: 61)
        songImageTopLeft.cornerRadius = 0
        songImageTopLeft.borderWidth = 0.25
        songImageTopLeft.borderColor = UIColor.white.cgColor
 
        songs.shuffle()
        songImageTopRight.style.preferredSize = .init(width: 61, height: 61)
        songImageTopRight.cornerRadius = 0
        songImageTopRight.borderWidth = 0.25
        songImageTopRight.borderColor = UIColor.white.cgColor
    
        songs.shuffle()
        songImageBottomLeft.style.preferredSize = .init(width: 61, height: 61)
        songImageBottomLeft.cornerRadius = 0
        songImageBottomLeft.borderWidth = 0.25
        songImageBottomLeft.borderColor = UIColor.white.cgColor
        
        songs.shuffle()
        songImageBottomRight.style.preferredSize = .init(width: 61, height: 61)
        songImageBottomRight.cornerRadius = 0
        songImageBottomRight.borderWidth = 0.25
        songImageBottomRight.borderColor = UIColor.white.cgColor
        
        collectionImage.style.preferredSize = .init(width: 122, height: 122)
        collectionImage.cornerRadius = 0
        collectionImage.borderWidth = 0.25
        collectionImage.borderColor = UIColor.white.cgColor
        
        shuffleIcon.image = UIImage(named: "Shuffle")
        shuffleIcon.style.preferredSize = CGSize(width: 40, height: 40)
        shuffleIcon.contentMode = .scaleAspectFill
        shuffleIcon.clipsToBounds = true
        
        playIcon.image = UIImage(named: "playlistPlayIcon")
        playIcon.style.preferredSize = CGSize(width: 40, height: 40)
        playIcon.contentMode = .scaleAspectFill
        playIcon.clipsToBounds = true
      
        playlistImageBackground.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        playlistImageBackground.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width - 80)
        playlistImageBackground.borderWidth = 1
        
        shuffleButtonBackground.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        shuffleButtonBackground.style.preferredSize = CGSize(width: 120, height: 40)
        shuffleButtonBackground.cornerRadius = 10
        shuffleButtonBackground.addTarget(self, action: #selector(addSongClicked), forControlEvents: .touchUpInside)
        
        playButtonBackground.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        playButtonBackground.style.preferredSize = CGSize(width: 120, height: 40)
        playButtonBackground.cornerRadius = 10
        
        playlistTitle.delegate = self
        
        if playlistEdit == false {
            playlistTitle.isUserInteractionEnabled = false
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: playlistCreatorGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
        
        else if isEditingNewPlaylist == true {
            
            playlistNameGlobal = currentPlaylistName
            playlistTitle.isUserInteractionEnabled = true
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: "You", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
        
        else {
            playlistTitle.isUserInteractionEnabled = false
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: playlistCreatorGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
        
        by.attributedText = NSAttributedString(string: "By ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])

        playlistBio.attributedText = NSAttributedString(string: "A mix to get you pumped AF", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 9)])
        playlistBio.maximumNumberOfLines = 2
        
        lastUpdate.attributedText = NSAttributedString(string: "Last Updated", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
       
        lastUpdateTimeStamp.attributedText = NSAttributedString(string: "- 2 hours ago", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 9)])
    }
    

    @objc func addSongClicked(){
        playlistOpened = false
        self.closestViewController?.navigationController?.popViewController(animated: true)
        self.closestViewController?.dismiss(animated: true, completion: nil)
        currentlyCreatingPlaylist = true
        NotificationCenter.default.post(name: Notification.Name("switchIconToAdd"), object: nil)
    }
    
    override func didEnterVisibleState() {
        if playlistEdit == false {
            playlistTitle.isUserInteractionEnabled = false
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: playlistCreatorGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
        
        else if isEditingNewPlaylist == true {
            playlistNameGlobal = currentPlaylistName
            
            playlistTitle.isUserInteractionEnabled = true
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: "You", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
        
        else {
            playlistTitle.isUserInteractionEnabled = false
            playlistTitle.attributedPlaceholderText =  NSAttributedString(string: playlistNameGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)])
            playlistTitle.backgroundColor = .clear
            playlistTitle.style.preferredSize = playlistNameGlobal.sizeOfString(font: UIFont.systemFont(ofSize: 21))
            playlistTitle.enablesReturnKeyAutomatically = true
            playlistTitle.typingAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            playlistCreator.attributedText = NSAttributedString(string: playlistCreatorGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 1, green: 0.8549, blue: 0, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10)])
        }
    }
}

