//
//  PlaylistCell.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-20.
//  Copyright © 2020 Soundbar LLC. All rights reserved.
//

import AsyncDisplayKit

var songsCellArray: [SongsCell] = []
var songCellCurrent: [SongsCell] = []

class PlaylistCell: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    var collectionNode: ASCollectionNode!

    var songs: [SongPresentation]!
    var textType: String!

    var audioPlayer: AudioHandler!
    var animationHandler: SongsAnimationHandler!
    
    init(title: String, songs: [SongPresentation]?, audio: AudioHandler, animationHandle: SongsAnimationHandler) {
        super.init()
        
        self.songs = songs
        audioPlayer = audio
        animationHandler = animationHandle
        textType = title
        
        collectionNode = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            
            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            collection.backgroundColor = .clear
            return collection
        }()
        
        self.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1)
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: CGFloat(songs?.count ?? 0) * 110)
    }
    
    override func didLoad() {
        collectionNode.view.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
       
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: collectionNode)

        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 0,
                                       justifyContent: .center,
                                       alignItems: .center,
                                       children: [collectionInset])
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: vStack)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            let playlistCell = SongsCell(type: self!.textType, clickedSong: self!.songs[indexPath.row], audio: self!.audioPlayer, animationHandle: self!.animationHandler)
                playlistCell.delegatePlaylist = self
                return playlistCell
        }
    }
}

extension PlaylistCell : SongsPlaylistCellDelegate {
    func delete(playlistCell: SongsCell){
        if let indexPath = collectionNode?.indexPath(for: playlistCell) {
            songs.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
    
    func deleteTemp(tempCell: SongsCell){
        if let indexPath = collectionNode.indexPath(for: tempCell) {
            songs.remove(at: indexPath.row)
            songsCellArray[indexPath.row].moreIcon.image = UIImage(named: "AddPlaylistIcon")
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}


