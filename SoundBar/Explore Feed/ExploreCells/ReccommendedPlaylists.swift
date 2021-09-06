//
//  RecommendedPlaylists.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2021-03-21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var playlistImageGlobal = String()
var playlistNameGlobal = String()
var playlistCreatorGlobal = String()

var currentPlaylistName = String()

var fullSongImageGlobal = String()
var artistPFPGlobal = String()
var fullSongNameGlobal = String()
var fullArtistNameGlobal = String()

var recommendedPlaylistsCellData:[String: RecommendedPlaylists]?

class RecommendedPlaylists: BaseCellNode {
    
    let playlistName = ASTextNode()
    let playlistCreatedBy = ASTextNode()
    
    var topSong: SongPresentation!
    var playlist: SongPlaylists!
    
    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    
    var playlistImage = ASImageNode()
    var playlistImageTwo = ASImageNode()
    
    var emptyCellOne = ASImageNode()
    var emptyCellTwo = ASImageNode()
    
    init(playlists: SongPlaylists, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        audioPlayer = audio
        animationHandler = animationHandle
        playlist = playlists
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

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
        
        let textStackInset = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 3,
                                               justifyContent: .center,
                                               alignItems: .baselineFirst,
                                               children: [playlistName, playlistCreatedBy])
        
        let textInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 20), child: textStackInset)
        
        let fullLayout = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 5,
                                           justifyContent: .center,
                                           alignItems: .baselineFirst,
                                           children: [songsStack, textInset])
        
        return fullLayout
    }
    
    private func setupNodes() {
        playlistName.attributedText = NSAttributedString(string: "\((playlist.playlistName ?? ""))", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        
        playlistCreatedBy.attributedText = NSAttributedString(string: "Created by: \((playlist.creator ?? ""))", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        
        songImageTopLeft.image = UIImage(named: playlist .imageLink ?? "")
        songImageTopLeft.style.preferredSize = .init(width: 100, height: 100)
        songImageTopLeft.cornerRadius = 0
        songImageTopLeft.borderWidth = 0.5
        songImageTopLeft.borderColor = UIColor.white.cgColor
        songImageTopLeft.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
    
        songImageTopRight.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageTopRight.style.preferredSize = .init(width: 100, height: 100)
        songImageTopRight.cornerRadius = 0
        songImageTopRight.borderWidth = 0.5
        songImageTopRight.borderColor = UIColor.white.cgColor
        songImageTopRight.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        songImageBottomLeft.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageBottomLeft.style.preferredSize = .init(width: 100, height: 100)
        songImageBottomLeft.cornerRadius = 0
        songImageBottomLeft.borderWidth = 0.5
        songImageBottomLeft.borderColor = UIColor.white.cgColor
        songImageBottomLeft.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        songImageBottomRight.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
        songImageBottomRight.style.preferredSize = .init(width: 100, height: 100)
        songImageBottomRight.cornerRadius = 0
        songImageBottomRight.borderWidth = 0.5
        songImageBottomRight.borderColor = UIColor.white.cgColor
        songImageBottomRight.addTarget(self, action: #selector(playlistClicked), forControlEvents: .touchUpInside)
        
        if playlist.songs?.count == 1 {
            playlistImage.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 122, height: 122)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
        }
        else if playlist.songs?.count == 2{
            playlistImage.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 122, height: 61)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
            
            playlistImageTwo.image = UIImage(named: playlist.songs?[1].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 122, height: 61)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        else if playlist.songs?.count == 3{
            songImageTopLeft.image = UIImage(named: playlist.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlist.songs?[1].imageLink ?? "")

            playlistImageTwo.image = UIImage(named: playlist.songs?[2].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 122, height: 61)
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
            playlistImage.style.preferredSize = CGSize(width: 124, height: 124)
            playlistImage.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            playlistImage.borderWidth = 1
        }
    }
    
    @objc func playlistClicked() {
        audioPlayer.pauseCurrentSong()
        
        playlistImageGlobal = playlist.imageLink
        playlistNameGlobal = playlist.playlistName
        playlistCreatorGlobal = playlist.creator
        
        playlistOpened = true
        audioPlayer.pauseCurrentSong()
        recommendedPlaylistsCellData = ["RecommendedPlaylists": self]
        playlistNameGlobal = playlistName.attributedText?.string ?? ""
        songsCellData = playlist.songs!
        
        let vc = PlaylistPageViewController(audio: audioPlayer, playlistSongs: songsCellData, animationHandle: animationHandler)
        vc.hidesBottomBarWhenPushed = true
        self.closestViewController?.navigationController?.pushViewController(vc, animated: true)
        
        NotificationCenter.default.post(name: NSNotification.Name("switchFullSongData"), object: nil, userInfo: ["songs" : playlist.songs!])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
}



