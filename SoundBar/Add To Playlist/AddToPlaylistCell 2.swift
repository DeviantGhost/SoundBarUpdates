//
//  AddToPlaylistCell.swift
//  SoundBar
//
//  Created by Justin Cose on 7/27/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class AddToPlaylistCell: BaseCellNode {
    
    let playlistName = ASTextNode()
    let playlistSongCount = ASTextNode()
    
    var audioPlayer: AudioHandler!
    
    var playlists = SongPlaylists()
    
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    
    var playlistImage = ASImageNode()
    var playlistImageTwo = ASImageNode()
    
    var emptyCellOne = ASImageNode()
    var emptyCellTwo = ASImageNode()
    
    init(playlist: SongPlaylists) {
        super.init()
        
        playlists = playlist
     
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
        
        if(self.playlists.songs?.count == 0){
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
        
        else if(self.playlists.songs?.count == 1){
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
        
        else if(self.playlists.songs?.count == 2){
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
        
        else if(self.playlists.songs?.count == 3){
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
        
        else if(self.playlists.songs!.count >= 4){
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
        
        let fullStackLine = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 4,
                                          justifyContent: .center,
                                          alignItems: .center,
                                          children: [songsStack, playlistName, playlistSongCount])
        
        return fullStackLine
    }
    
    func setupNodes() {
        playlistImage.image = UIImage(named: playlists.imageLink)
        playlistImage.style.preferredSize = CGSize(width: 120, height: 120)
        playlistImage.cornerRadius = 0
        playlistImage.borderWidth = 1
        playlistImage.borderColor = UIColor.white.cgColor
        playlistImage.addTarget(self, action: #selector(playlistSelected), forControlEvents: .touchUpInside)
        
        playlistName.attributedText = NSAttributedString(string: playlists.playlistName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        playlistSongCount.attributedText = NSAttributedString(string: "\(playlists.songs!.count) songs", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        songImageTopLeft.image = UIImage(named: playlists.imageLink ?? "")
        songImageTopLeft.style.preferredSize = .init(width: 60, height: 60)
        songImageTopLeft.cornerRadius = 0
        songImageTopLeft.borderWidth = 0.5
        songImageTopLeft.borderColor = UIColor.white.cgColor
        songImageTopLeft.addTarget(self, action: #selector(playlistSelected), forControlEvents: .touchUpInside)
    
        songImageTopRight.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
        songImageTopRight.style.preferredSize = .init(width: 60, height: 60)
        songImageTopRight.cornerRadius = 0
        songImageTopRight.borderWidth = 0.5
        songImageTopRight.borderColor = UIColor.white.cgColor
        songImageTopRight.addTarget(self, action: #selector(playlistSelected), forControlEvents: .touchUpInside)
        
        songImageBottomLeft.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
        songImageBottomLeft.style.preferredSize = .init(width: 60, height: 60)
        songImageBottomLeft.cornerRadius = 0
        songImageBottomLeft.borderWidth = 0.5
        songImageBottomLeft.borderColor = UIColor.white.cgColor
        songImageBottomLeft.addTarget(self, action: #selector(playlistSelected), forControlEvents: .touchUpInside)
        
        songImageBottomRight.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
        songImageBottomRight.style.preferredSize = .init(width: 60, height: 60)
        songImageBottomRight.cornerRadius = 0
        songImageBottomRight.borderWidth = 0.5
        songImageBottomRight.borderColor = UIColor.white.cgColor
        songImageBottomRight.addTarget(self, action: #selector(playlistSelected), forControlEvents: .touchUpInside)
        
        if playlists.songs?.count == 1 {
            playlistImage.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 120, height: 120)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
        }
        else if playlists.songs?.count == 2{
            playlistImage.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = CGSize(width: 120, height: 60)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
            
            playlistImageTwo.image = UIImage(named: playlists.songs?[1].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 120, height: 60)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        else if playlists.songs?.count == 3{
            songImageTopLeft.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlists.songs?[1].imageLink ?? "")

            playlistImageTwo.image = UIImage(named: playlists.songs?[2].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: 120, height: 60)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        else if playlists.songs!.count >= 4{
            songImageTopLeft.image = UIImage(named: playlists.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlists.songs?[1].imageLink ?? "")
            songImageBottomLeft.image = UIImage(named: playlists.songs?[2].imageLink ?? "")
            songImageBottomRight.image = UIImage(named: playlists.songs?[3].imageLink ?? "")
        }
        else{
            playlistImage.style.preferredSize = CGSize(width: 120, height: 120)
            playlistImage.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            playlistImage.borderWidth = 1
        }
    }
    
    @objc func playlistSelected() {
        self.closestViewController?.dismiss(animated: true, completion: nil)
        
        successType = "Added To Playlist"
        NotificationCenter.default.post(name: Notification.Name("success"), object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}
