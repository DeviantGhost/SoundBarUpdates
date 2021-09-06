//
//  ShareFeedCells.swift
//  SoundBar
//
//  Created by Justin Cose on 8/17/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class shareCellData: BaseCellNode {
    
    let shareImage = ASImageNode()
    let backgroundCircle = ASImageNode()
    
    let backgroundNode = ASImageNode()
    
    let shareText = ASTextNode()
    let shareTextBox = ASImageNode()
    
    var shareIcon = String()
    var shareType = String()
    
    var cellSeperator = ASImageNode()
    
    var favorited = false
    
    var audioPlayer: AudioHandler!
    
    init(caption: String, trendingData: String) {
        super.init()
        
        audioPlayer = AudioHandler()
        
        shareIcon = trendingData
        shareType = caption
        
        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let centerIcon = ASCenterLayoutSpec(centeringOptions: .XY, child: shareImage)
        let iconOverlay = ASOverlayLayoutSpec(child: backgroundCircle, overlay: centerIcon)

        let vStack = ASStackLayoutSpec(direction: .horizontal,
                                       spacing: 7,
                                       justifyContent: .start,
                                       alignItems: .center,
                                       children: [iconOverlay, shareText])
        
        let overlay = ASOverlayLayoutSpec(child: backgroundNode, overlay: vStack)
        
        let hStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 0,
                                       justifyContent: .center,
                                       alignItems: .baselineFirst,
                                       children: [overlay, cellSeperator])
        
        return hStack
    }
    
    private func setupNodes() {
        backgroundNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 49.5)
        backgroundNode.backgroundColor = UIColor(red: 0.045, green: 0.045, blue: 0.045, alpha: 1)
        
        shareImage.style.preferredSize = .init(width: 45, height: 45)
        shareImage.contentMode = .scaleAspectFill
        shareImage.image = UIImage(named: shareIcon)
        shareImage.cornerRadius = 40/2
        
        backgroundCircle.style.preferredSize = .init(width: 45, height: 45)
        backgroundCircle.cornerRadius = 45/2
        backgroundCircle.addTarget(self, action: #selector(shareOptionClicked), forControlEvents: .touchUpInside)
        
        shareText.attributedText = NSAttributedString(string: shareType, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
        
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.5)
        cellSeperator.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
    }
    
    @objc func shareOptionClicked() {
        if shareType == "UnFavorite" {
            self.closestViewController?.dismiss(animated: false, completion: nil)
            songCellCurrent[0].delegate?.delete(cell: (songCellCurrent[0]))
        }
        
        else if shareType == "Repost" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            successType = "Repost"
            NotificationCenter.default.post(name: Notification.Name("success"), object: nil)
        }
        
        else if shareType == "Add To Playlist" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("switchToPlaylistView"), object: nil)
        }
        
        else if shareType == "View Artist" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("switchToViewArtist"), object: nil)
        }
        
        else if shareType == "Send" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("switchToSendFeed"), object: nil)
        }
        
        else if shareType == "Message" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("messageArtistShare"), object: nil)
        }
        
        else if shareType == "Report" {
            self.closestViewController?.dismiss(animated: true, completion: nil)
            successType = "Reported"
            NotificationCenter.default.post(name: Notification.Name("success"), object: nil)
        }
        
        else if shareType == "Edit Playlist" {
            if playlistOpened == true {
                self.closestViewController?.dismiss(animated: false, completion: nil)
                didCreatePlaylist = true
                NotificationCenter.default.post(name: Notification.Name("editPlaylist"), object: nil)
            }
            else{
                self.closestViewController?.dismiss(animated: false, completion: nil)
                playlistsCellData?["PlaylistsCell"]?.playlistClicked()
                NotificationCenter.default.post(name: Notification.Name("editPlaylist"), object: nil)
            }
        }
        
        else if shareType ==  "Delete Playlist" {
            playlistsCellData?["PlaylistsCell"]?.delegate?.delete(cell: (playlistsCellData?["PlaylistsCell"])!)
            self.closestViewController?.dismiss(animated: true, completion: nil)
            NotificationCenter.default.post(name: Notification.Name("deletePlaylist"), object: nil)
        }
        
        else if shareType == "Delete Repost" {
            if currentTabHome == "Tracks" {
                self.closestViewController?.dismiss(animated: true, completion: nil)
                homeCellCurrent[0].delegateTrack?.deleteTrack(cell: (homeCellCurrent[0]))
            }
            else{
                self.closestViewController?.dismiss(animated: true, completion: nil)
                homeCellCurrent[0].delegateRepost?.deleteRepost(cell: (homeCellCurrent[0]))
            }
        }
        
        else if shareType == "Unfollow" {
            artistCellData?["ArtistsCell"]?.delegate?.delete(cell: (artistCellData?["ArtistsCell"])!)
            self.closestViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NotificationCenter.default.post(name: NSNotification.Name("touchesDidBegan"), object: nil)
    }
    
}
