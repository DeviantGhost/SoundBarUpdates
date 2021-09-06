//
//  BottomSongDisplayNode.swift
//  SoundBar
//
//  Created by Justin Cose on 2/23/21.
//  Copyright © 2021 Soundbar LLC. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class QueueDisplayPage: BaseNode, ASTableDelegate, ASTableDataSource  {
    
    let tableNode = ASTableNode()

    var audioPlayer: AudioHandler!

    var playlistSongs: [SongPresentation]!
    var queuePageCurrent: QueuePageCurrent!
    var queuePageCell: QueuePageCell!
    
    init(audio: AudioHandler, data: [SongPresentation]) {
        super.init()
        
        playlistSongs = data
        audioPlayer = audio
        tableNode.allowsSelection = false
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.backgroundColor = .clear
        tableNode.zPosition = 6
        tableNode.position.y = 300
        tableNode.view.isScrollEnabled = false
    }
    
    override func didEnterVisibleState() {
        print("QueueDisplay: Running")

    }
    
    func findIndexNumber(song: String) -> Int {
        for (index, item) in playlistSongs.enumerated() {
            if item.songName == song {
                return index
            }
        }
        return 0
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: tableNode)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 0), CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        print("fetching new data")
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            if indexPath.section == 0 {
                return QueuePageCurrent(audio: self!.audioPlayer, data: self!.playlistSongs)
            }
            else{
                return QueuePageCell(songs: self!.playlistSongs, audio: self!.audioPlayer)
            }
        }
    }
}




