//
//  PlaylistCell.swift
//  SoundBar
//
//  Created by Justin Cose on 2020-08-20.
//  Copyright © 2020 Soundbar LLC. All rights reserved.



import AsyncDisplayKit


class QueuePageCell: BaseCellNode, ASCollectionDelegate, ASCollectionDataSource {
    
    let upNext = ASTextNode()
    var collectionNode: ASCollectionNode!
    var isOtherArtist: Bool!

    let backgroundImageRecommended = ASImageNode()
    
    // datasources
    
    let cellSeparatorImage = ASImageNode()
    let cellSeparatorImageTwo = ASImageNode()
   
    var songs: [SongPresentation]!
    var textType: String!
    let backgroundImageTop = ASImageNode()
    let backgroundImageBottom = ASImageNode()

    var audioPlayer: AudioHandler!
//    var animationHandler: SongsAnimationHandler!
    
    init(songs: [SongPresentation]?, audio: AudioHandler) {
        super.init()
        self.songs = songs
        audioPlayer = audio
        NotificationCenter.default.addObserver(self, selector: #selector(queuePageClosed), name: NSNotification.Name(rawValue: "closeQueuePage"), object: nil)
//        animationHandler = animationHandle
        upNext.attributedText = NSAttributedString(string: "Up Next:", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        
        collectionNode = {
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 80)
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 5
            flowLayout.collectionView?.showsVerticalScrollIndicator = false

            let collection = ASCollectionNode(collectionViewLayout: flowLayout)
            
            collection.backgroundColor = .clear
            
            return collection
        }()
        
        self.backgroundColor = .clear

        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.backgroundColor = .clear
        collectionNode.style.preferredSize = .init(width: UIScreen.main.bounds.width, height: 425)
        
        print("QueuePageCell: Did Initialize")
        
//        DispatchQueue.main.async {
//
//            self.collectionNode.layer.shadowColor = UIColor.darkGray.cgColor
//            self.collectionNode.layer.shadowOffset = CGSize(width: 0, height: 3)
//            self.collectionNode.layer.shadowOpacity = 0.3
//            self.collectionNode.layer.shadowRadius = 1
//            self.collectionNode.clipsToBounds = false
//        }
        
    }
    
    
    
    override func didLoad() {
        collectionNode.view.showsHorizontalScrollIndicator = false
        print("QueuePageCell: \(songs!.count - 1) number of songs")
        print("QueuePageCell: Did Load")

    }
    
    @objc func queuePageClosed(){
        upNext.closeQueuePage()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
//      let titleInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 5, bottom: 15, right: 0), child: collectionTitle)
        let upNextInset = ASInsetLayoutSpec(insets: .init(top: 0, left: 25, bottom: 0, right: 0), child: upNext)
        
        let collectionInset = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 0, right: 0), child: collectionNode)

        let vStack = ASStackLayoutSpec(direction: .vertical,
                                       spacing: 5,
                                       justifyContent: .start,
                                       alignItems: .start,
                                       children: [upNextInset, collectionInset])
        return vStack
    }

    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return songs.count - 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        return { [weak self] in
            guard self != nil else { return ASCellNode() }
            
            let cell = QueueCellSong(clickedSong: self!.songs[indexPath.row + 1], audio: self!.audioPlayer)
            cell.delegate = self
            
            return cell
        }
    }
}

extension QueuePageCell : QueueCellDelegate {
    
    func delete(cell: QueueCellSong){
        if let indexPath = collectionNode?.indexPath(for: cell) {
            songs.remove(at: indexPath.row)
            collectionNode.deleteItems(at: [indexPath])
        }
    }
}


