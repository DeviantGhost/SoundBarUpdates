//
//  SearchHistoryCells.swift
//  SoundBar
//
//  Created by Justin Cose on 7/19/21.
//  Copyright © 2021 Danesh Rajasolan. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class SearchHistoryCells: BaseCellNode {

    var song: SongPresentation!
    
    var backgroundCell = ASImageNode()
    var lineSeperator = ASImageNode()
    
    let playlistImage = ASImageNode()
    let textNode = ASTextNode()
    let backgroundImageNode = ASImageNode()
    let moreButtonNode = ASButtonNode()
    let listensNode = ASButtonNode()
    let listenCount = ASTextNode()
    let headphonesImage = ASImageNode()
    
    let nameTextNode = ASTextNode()
    let songTextNode = ASTextNode()
    
    var leftPadding = ASImageNode()
    
    var cellType = String()
    
    var songBox = ASImageNode()
    var nameBox = ASImageNode()
    
    var cellTypeTextNode = ASTextNode()
    var goButton = ASImageNode()
    
    var songsArray = hotBarsDataSourceStatic
    
    var artist: ProfileHeader!
    
    var imageReroll = Int.random(in: 0..<3)
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    
    var emptyCellOne = ASImageNode()
    var emptyCellTwo = ASImageNode()
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    var textType: String = "Favorites"
    
    var createdByString = String()
    var playlist: SongPlaylists!
    
    var playlistName = String()

    init(playlist: String, createdBy: String, type: String = "History", clickedSong: SongPresentation, audio: AudioHandler, animationHandle: SongsAnimationHandler, cellType: String) {
        super.init()
        
        songsArray.shuffle()
        
        playlistName = playlist
        self.cellType = cellType
        createdByString = createdBy
        song = clickedSong
        audioPlayer = audio
        animationHandler = animationHandle
        textType = type
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        if cellType == "Playlist" {
            
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
    
            if(imageReroll == 0){
                songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [emptyCellTwo, emptyCellOne])
                
                songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [songImageBottomLeft, songImageBottomRight])
            }else if(imageReroll == 1){
                songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [songImageTopLeft, emptyCellOne])
                
                songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [songImageBottomLeft, emptyCellTwo])
                
            }else if(imageReroll == 2){
                songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [emptyCellOne, songImageTopRight])
                
                songsBottomStack = ASStackLayoutSpec(direction: .horizontal,
                                                      spacing: 0,
                                                      justifyContent: .center,
                                                      alignItems: .center,
                                                      children: [songImageBottomLeft, emptyCellTwo])
            }
        
            let songsStack = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [songsTopStack, songsBottomStack])
            
            let songsOverlay = ASOverlayLayoutSpec(child: playlistImage, overlay: songsStack)
            
            let hBackgroundStack = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 0,
                                                     justifyContent: .center,
                                                     alignItems: .center,
                                                     children: [backgroundImageNode])
            
            let songOverlay = ASOverlayLayoutSpec(child: songBox, overlay: songTextNode)
            
            let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: songOverlay)
            
            let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textCenter)
            
            let rightPadding = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .end,
                                                 alignItems: .stretch,
                                                 children: [moreButtonNode])
            
            let moreButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 35), child: rightPadding)
            
            moreButtonInset.style.flexGrow = 1
            
            let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [headphonesImage, listenCount])
            
            let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)
            
            let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: vStackListenCenter)
            
            let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
            
            let playlistInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: songsOverlay)
            
            let playlistImageOverlay = ASOverlayLayoutSpec(child: playlistInset, overlay: listenBoxCenter)
            
            let playlistInsetOverlay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImageOverlay)
            
            let typeAndGoButton = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 1,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [cellTypeTextNode, goButton])
            
            let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [leftPadding, playlistInsetOverlay, textNodeInset, typeAndGoButton])
            
            let fullOverlay = ASOverlayLayoutSpec(child: hBackgroundStack, overlay: hCellStack)
            
            let centerOverlay = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: fullOverlay)
            
            let fullStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: centerOverlay)
            
            let overlay = ASOverlayLayoutSpec(child: backgroundCell, overlay: fullStackInset)
            
            let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [overlay, lineSeperator])

            return fullStackLine
            
        }
        
        else if cellType == "Artist" {
    
            let hBackgroundStack = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 0,
                                                     justifyContent: .center,
                                                     alignItems: .center,
                                                     children: [backgroundImageNode])
            
            let songOverlay = ASOverlayLayoutSpec(child: songBox, overlay: songTextNode)
            
            let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: songOverlay)
            
            let textNodeInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 0, right: 0), child: textCenter)
            
            let rightPadding = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .end,
                                                 alignItems: .stretch,
                                                 children: [moreButtonNode])
            
            let moreButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 35), child: rightPadding)
            
            moreButtonInset.style.flexGrow = 1
            
            let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [headphonesImage, listenCount])
            let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)
            let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: vStackListenCenter)
            let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
            

            let playlistInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImage)
            let playlistImageOverlay = ASOverlayLayoutSpec(child: playlistInset, overlay: listenBoxCenter)
            let playlistInsetOverlay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImageOverlay)
        
            let typeAndGoButton = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 10,
                                                 justifyContent: .end,
                                                 alignItems: .center,
                                                 children: [cellTypeTextNode, goButton])
            
            let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [leftPadding, playlistInsetOverlay, textNodeInset])
            
            let fullHCellStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [hCellStack, typeAndGoButton])
            
            let fullOverlay = ASOverlayLayoutSpec(child: hBackgroundStack, overlay: fullHCellStack)
            let centerOverlay = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: fullOverlay)
            let fullStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: centerOverlay)
            
            let overlay = ASOverlayLayoutSpec(child: backgroundCell, overlay: fullStackInset)
            
            let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [overlay, lineSeperator])

            return fullStackLine
        }
        
       else {
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
            
            let rightPadding = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 0,
                                                 justifyContent: .end,
                                                 alignItems: .stretch,
                                                 children: [moreButtonNode])
            
            let moreButtonInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 35), child: rightPadding)
            
            moreButtonInset.style.flexGrow = 1
            
            let vStackListen = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 0,
                                                 justifyContent: .center,
                                                 alignItems: .center,
                                                 children: [headphonesImage, listenCount])
            
            let vStackListenCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: vStackListen)

            let listenOverlay = ASOverlayLayoutSpec(child: listensNode, overlay: vStackListenCenter)
        
            let listenBoxCenter = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: listenOverlay)
            
            let playlistInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImage)
            
            let playlistImageOverlay = ASOverlayLayoutSpec(child: playlistInset, overlay: listenBoxCenter)
            
            let playlistInsetOverlay = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: playlistImageOverlay)
            
            let typeAndGoButton = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 10,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [cellTypeTextNode, goButton])
            
            let hCellStack = ASStackLayoutSpec(direction: .horizontal,
                                               spacing: 2,
                                               justifyContent: .start,
                                               alignItems: .center,
                                               children: [leftPadding, playlistInsetOverlay, textNodeInset, typeAndGoButton])
            
            let fullOverlay = ASOverlayLayoutSpec(child: hBackgroundStack, overlay: hCellStack)
            
            let centerOverlay = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: fullOverlay)
            
            let fullStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: centerOverlay)
            
            let overlay = ASOverlayLayoutSpec(child: backgroundCell, overlay: fullStackInset)
            
            let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                              spacing: 0,
                                              justifyContent: .center,
                                              alignItems: .center,
                                              children: [overlay, lineSeperator])

            return fullStackLine
        }
    }
    
    private func setupNodes() {
        leftPadding.style.preferredSize = .init(width: 15, height: 50)
        
        songBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.575, height: 20)
        nameBox.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 1.575, height: 20)
        
        if cellType == "Playlist" {
            emptyCellOne.style.preferredSize = .init(width: 24.5, height: 24.5)
            emptyCellOne.cornerRadius = 0
            emptyCellOne.borderWidth = 0
            
            emptyCellTwo.style.preferredSize = .init(width: 24.5, height: 24.5)
            emptyCellTwo.cornerRadius = 0
            emptyCellTwo.borderWidth = 0
            
            playlistImage.image = UIImage(named: song.imageLink ?? "")
            playlistImage.style.preferredSize = .init(width: 50, height: 50)
            playlistImage.cornerRadius = 0
            playlistImage.borderWidth = 1
            playlistImage.borderColor = UIColor.white.cgColor
            
            songImageTopLeft.image = UIImage(named: songsArray[0].imageLink ?? "")
            songImageTopLeft.style.preferredSize = .init(width: 24.5, height: 24.5)
            songImageTopLeft.cornerRadius = 0
            songImageTopLeft.borderWidth = 1
            songImageTopLeft.borderColor = UIColor.white.cgColor
            songsArray.shuffle()
            
            songImageTopRight.image = UIImage(named: songsArray[0].imageLink ?? "")
            songImageTopRight.style.preferredSize = .init(width: 24.5, height: 24.5)
            songImageTopRight.cornerRadius = 0
            songImageTopRight.borderWidth = 1
            songImageTopRight.borderColor = UIColor.white.cgColor
            songsArray.shuffle()
            
            songImageBottomLeft.image = UIImage(named: songsArray[0].imageLink ?? "")
            songImageBottomLeft.style.preferredSize = .init(width: 24.5, height: 24.5)
            songImageBottomLeft.cornerRadius = 0
            songImageBottomLeft.borderWidth = 1
            songImageBottomLeft.borderColor = UIColor.white.cgColor
            songsArray.shuffle()
            
            songImageBottomRight.image = UIImage(named: songsArray[0].imageLink ?? "")
            songImageBottomRight.style.preferredSize = .init(width: 24.5, height: 24.5)
            songImageBottomRight.cornerRadius = 0
            songImageBottomRight.borderWidth = 1
            songImageBottomRight.borderColor = UIColor.white.cgColor
            songsArray.shuffle()
            
            songTextNode.attributedText = NSAttributedString(string: playlistName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            songTextNode.maximumNumberOfLines = 2

            nameTextNode.attributedText = NSAttributedString(string: createdByString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            nameTextNode.maximumNumberOfLines = 2

            goButton.image = UIImage(named: "GoButton")
            goButton.style.preferredSize = .init(width: 15, height: 30)
            goButton.contentMode = .scaleAspectFill
        }
        
        else if cellType == "Artist" {
            playlistImage.image = UIImage(named: song.profileImageLink ?? "")
            playlistImage.style.preferredSize = .init(width: 50, height: 50)
            playlistImage.cornerRadius = 50/2
            playlistImage.contentMode = .scaleAspectFill

            
            songTextNode.attributedText = NSAttributedString(string: song.artistID ?? "Justin Cose", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            songTextNode.maximumNumberOfLines = 2


            goButton.image = UIImage(named: "GoButton")
            goButton.style.preferredSize = .init(width: 15, height: 30)
            goButton.contentMode = .scaleAspectFill
        }
        
        else if cellType == "Song" {
            playlistImage.image = UIImage(named: song.imageLink ?? "")
            playlistImage.style.preferredSize = .init(width: 50, height: 50)
            playlistImage.cornerRadius = 10
            playlistImage.contentMode = .scaleAspectFill

            songTextNode.attributedText = NSAttributedString(string: song.songName ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
            songTextNode.maximumNumberOfLines = 2

            nameTextNode.attributedText = NSAttributedString(string: song.artistID ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
            nameTextNode.maximumNumberOfLines = 2
        
            goButton.style.preferredSize = .init(width: 15, height: 30)
        }
        
        cellTypeTextNode.attributedText = NSAttributedString(string: cellType, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        cellTypeTextNode.maximumNumberOfLines = 1
        
        lineSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        lineSeperator.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        
        backgroundCell.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 65)
        
        backgroundImageNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 65)
    }
}


