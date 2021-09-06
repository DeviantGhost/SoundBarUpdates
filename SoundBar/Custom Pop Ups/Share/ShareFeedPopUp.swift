//
//  ShareFeedPopUp.swift
//  SoundBar
//
//  Created by Justin Cose on 8/5/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

var moreType = "Song"
var isEditingNewPlaylist = false

class ShareFeedPopUp: BaseNode, ASCollectionDelegate, ASCollectionDataSource,  UICollectionViewDelegateFlowLayout {
    
    var ShareIconsCollectionNode: ASCollectionNode!
    
    var shareIconsCell = ASImageNode()
    var shareProfilesCell = ASImageNode()
    var shareSocialsCell = ASImageNode()
    
    var cancelBackground = ASImageNode()
    var cancel = ASTextNode()
    var cancelButton = ASButtonNode()
    
    var topBackground = ASImageNode()
    var contentImage = ASImageNode()
    
    var titleOne = ASTextNode()
    var titleTwo = ASTextNode()

    var playlistImage = ASImageNode()
    var playlistImageTwo = ASImageNode()
    
    var songImageTopLeft = ASImageNode()
    var songImageTopRight = ASImageNode()
    var songImageBottomLeft = ASImageNode()
    var songImageBottomRight = ASImageNode()
    
    var cellSeperator = ASImageNode()
    
    var ShareIconsCollectionNodeAssets = ["FavoriteShareIcon", "RepostShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
    var ShareIconsCollectionNodeCaptions = ["Favorite", "Repost",  "Add To Playlist", "Send", "View Artist"]
    
    var cellCount: Int!
    
    override init() {
        super.init()

        if moreType == "Song" {
            ShareIconsCollectionNodeAssets = ["FavoriteShareIcon", "RepostShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Unfavorite", "Repost",  "Add To Playlist", "Send", "View Artist"]
        }
        
        else if moreType == "RepostSong" {
            ShareIconsCollectionNodeAssets = ["RemoveShareIcon", "FavoriteShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Delete Repost", "Favorite", "Add To Playlist", "Send", "View Artist"]
        }
        
        else if moreType == "ArtistSong" {
            ShareIconsCollectionNodeAssets = ["FavoriteShareIcon", "RepostShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Favorite", "Repost",  "Add To Playlist", "Send", "View Artist"]
        }
        
        else if moreType == "PlaylistSong" {
            ShareIconsCollectionNodeAssets = ["RemoveShareIcon", "FavoriteShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Remove From Playlist", "Favorite", "Add To Playlist", "Send", "View Artist"]
        }
        
        else if moreType == "ArtistPage" {
            ShareIconsCollectionNodeAssets = ["RemoveShareIcon", "ShareSendIcon", "MessageSharePageIcon", "ReportShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Unfollow", "Message", "Send", "Block"]
        }
        
        else if moreType == "Artist" {
            ShareIconsCollectionNodeAssets = ["RemoveShareIcon", "ShareSendIcon", "MessageSharePageIcon", "ViewArtistShareIcon", "ReportShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Unfollow", "Message", "Send", "View Artist", "Block"]
        }
        
        else if moreType == "Playlist" {
            ShareIconsCollectionNodeAssets = ["RemoveShareIcon", "EditPlaylistShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon"]
            ShareIconsCollectionNodeCaptions = ["Delete Playlist", "Edit Playlist",  "Add To Playlist", "Send"]
        }
        
        else if moreType == "FullSongPage" {
            ShareIconsCollectionNodeAssets = ["FavoriteShareIcon", "RepostShareIcon", "AddToPlaylistShareIcon", "MessageSharePageIcon", "ViewArtistShareIcon"]
            ShareIconsCollectionNodeCaptions = ["Unfavorite", "Repost",  "Add To Playlist", "Send", "View Artist"]
        }
        
        ShareIconsCollectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            return collection
        }()
        
        ShareIconsCollectionNode.showsHorizontalScrollIndicator = false
        
        cellCount = ShareIconsCollectionNodeCaptions.count

        setupNodes()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let textStackStack = ASStackLayoutSpec(direction: .vertical,
                                                 spacing: 3,
                                                 justifyContent: .center,
                                                 alignItems: .baselineFirst,
                                                 children: [titleOne, titleTwo])
        
        let textCenter = ASCenterLayoutSpec(centeringOptions: .Y, sizingOptions: [], child: textStackStack)
        
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
        
        if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 0){
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
        
        else if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 1){
            songsTopStack = ASStackLayoutSpec(direction: .horizontal,
                                                  spacing: 0,
                                                  justifyContent: .center,
                                                  alignItems: .center,
                                                  children: [playlistImage])

            
        }
        
        else if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 2){
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
        
        else if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 3){
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
        
        else if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count ?? 0 >= 4){
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
        
        
        
        if(playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 1){
            songsStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 0,
                                           justifyContent: .center,
                                           alignItems: .center,
                                           children: [songsTopStack])
            
        }
        
        let songsOverlay = ASOverlayLayoutSpec(child: contentImage, overlay: songsStack)
        
        var wholeStack = ASStackLayoutSpec(direction: .horizontal,
                                                 spacing: 8,
                                                 justifyContent: .start,
                                                 alignItems: .center,
                                                 children: [contentImage, textCenter])
        
        if moreType == "Playlist" {
            wholeStack = ASStackLayoutSpec(direction: .horizontal,
                                                     spacing: 8,
                                                     justifyContent: .start,
                                                     alignItems: .center,
                                                     children: [songsOverlay, textCenter])
            
        }
        
        let wholeStackInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 10, bottom: 0, right: 0), child: wholeStack)
        let wholeOverlay = ASOverlayLayoutSpec(child: topBackground, overlay: wholeStackInset)
        let wholeOverlayInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: wholeOverlay)
        
        let centerCancelBackground = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: cancelBackground)
        let centerCancel = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: cancel)
        let cancelInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 10, right: 0), child: centerCancel)
        let centerCancelButton = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: [], child: cancelButton)
        let cancelTextButtonOverlay = ASOverlayLayoutSpec(child: centerCancelButton, overlay: cancelInset)
        let cancelBackgroundOverlay = ASOverlayLayoutSpec(child: centerCancelBackground, overlay: cancelTextButtonOverlay)
        
        let shareVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [ShareIconsCollectionNode, cancelBackgroundOverlay])
        
        let wholeVerticalStack = ASStackLayoutSpec(direction: .vertical,
                                                   spacing: 0,
                                                   justifyContent: .center,
                                                   alignItems: .center,
                                                   children: [wholeOverlayInset, cellSeperator, shareVerticalStack])
        
        return wholeVerticalStack
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
            return ShareIconsCollectionNodeAssets.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
                return shareCellData(caption: (self?.ShareIconsCollectionNodeCaptions[indexPath.row])!, trendingData: (self?.ShareIconsCollectionNodeAssets[indexPath.row])!)
        }
    }

    func setupNodes() {
        cellSeperator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.5)
        cellSeperator.backgroundColor = UIColor(red: 0.08, green: 0.08, blue: 0.08, alpha: 1)
        
        contentImage.style.preferredSize = .init(width: 75, height: 75)
        contentImage.image = UIImage(named: contentImageGlobal)
        
        if moreType == "Artist" {
            contentImage.cornerRadius = 75/2
        }

        songImageTopLeft.style.preferredSize = .init(width: contentImage.style.preferredSize.width / 2, height: contentImage.style.preferredSize.width / 2)
        songImageTopLeft.cornerRadius = 0
        songImageTopLeft.borderWidth = 0.25
        songImageTopLeft.borderColor = UIColor.white.cgColor

        songImageTopRight.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
        songImageTopRight.style.preferredSize = .init(width: contentImage.style.preferredSize.width / 2, height: contentImage.style.preferredSize.width / 2)
        songImageTopRight.cornerRadius = 0
        songImageTopRight.borderWidth = 0.25
        songImageTopRight.borderColor = UIColor.white.cgColor
       
        songImageBottomLeft.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
        songImageBottomLeft.style.preferredSize = .init(width: contentImage.style.preferredSize.width / 2, height: contentImage.style.preferredSize.width / 2)
        songImageBottomLeft.cornerRadius = 0
        songImageBottomLeft.borderWidth = 0.25
        songImageBottomLeft.borderColor = UIColor.white.cgColor

        songImageBottomRight.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
        songImageBottomRight.style.preferredSize = .init(width: contentImage.style.preferredSize.width / 2, height: contentImage.style.preferredSize.width / 2)
        songImageBottomRight.cornerRadius = 0
        songImageBottomRight.borderWidth = 0.25
        songImageBottomRight.borderColor = UIColor.white.cgColor

        topBackground.backgroundColor = UIColor(red: 0.045, green: 0.045, blue: 0.045, alpha: 1)
        topBackground.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 95)
        
        ShareIconsCollectionNode.dataSource = self
        ShareIconsCollectionNode.delegate = self
        ShareIconsCollectionNode.backgroundColor = UIColor().cellBackgroundGray()
        ShareIconsCollectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: CGFloat(cellCount) * 50)
        cancel.attributedText = NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        cancel.maximumNumberOfLines = 1
        
        cancelBackground.backgroundColor = UIColor().topBackgroundGray()
        cancelBackground.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 115)

        cancelButton.style.preferredSize = .init(width: 50, height: 20)
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), forControlEvents: .touchUpInside)
        
        titleOne.attributedText = NSAttributedString(string: titleOneGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        titleTwo.attributedText = NSAttributedString(string: titleTwoGlobal, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)])
        
        if playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 1 {
            playlistImage.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
            playlistImage.style.preferredSize = contentImage.style.preferredSize
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
        }
        
        else if playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 2 {
            playlistImage.style.preferredSize = CGSize(width: contentImage.style.preferredSize.width, height: contentImage.style.preferredSize.height / 2)
            playlistImage.contentMode = .scaleAspectFill
            playlistImage.clipsToBounds = true
            playlistImage.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
            
            playlistImageTwo.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[1].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: contentImage.style.preferredSize.width, height: contentImage.style.preferredSize.height / 2)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        
        else if playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count == 3 {
            songImageTopLeft.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[1].imageLink ?? "")

            playlistImageTwo.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[2].imageLink ?? "")
            playlistImageTwo.style.preferredSize = CGSize(width: contentImage.style.preferredSize.width, height: contentImage.style.preferredSize.height / 2)
            playlistImageTwo.contentMode = .scaleAspectFill
            playlistImageTwo.clipsToBounds = true
        }
        
        else if playlistsCellData?["PlaylistsCell"]?.playlist.songs?.count ?? 0 >= 4 {
            songImageTopLeft.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[0].imageLink ?? "")
            songImageTopRight.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[1].imageLink ?? "")
            songImageBottomLeft.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[2].imageLink ?? "")
            songImageBottomRight.image = UIImage(named: playlistsCellData?["PlaylistsCell"]?.playlist.songs?[3].imageLink ?? "")
        }
        
        else{
            playlistImage.style.preferredSize = CGSize(width: contentImage.style.preferredSize.width - 1, height: contentImage.style.preferredSize.height - 1)
            playlistImage.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
            playlistImage.borderWidth = 1
        }
    }
    
    @objc private func cancelButtonClicked() {
        NotificationCenter.default.post(name: Notification.Name("cancelSharePopUp"), object: nil)
    }
}

